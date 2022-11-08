var active_repo = 'demonstration';
var w;
function Ouvrir() {
  w=window.open("popup.html","pop1","width=200,height=200");
}
function Fermer() {
    w.close(); 
}
var sadaWorkflow = {
    wrapper: document.querySelector('#sada-workflow'),
    container: document.querySelector('#sada-workflow-container'),
    graph: document.querySelector('#sada-graph'),
    graph_inner: document.querySelector('#sada-graph-inner'),
    get_files: document.querySelector('#sada-get-files'),
    get_files_form: document.querySelector('#sada-get-files > form'),
    get_files_results: document.querySelector('#get-files-results')
}
var sadaResults = {
    container : document.querySelector('#sada-results'),
    wrapper : document.querySelector('#sada-wrapper')
}
var semSearchResults = {
    wrapper: document.querySelector('#sem-search-wrapper'),
    container: document.querySelector('#sem-search-results')
}
var allegro = {
    prefix: "https://allegro.callisto-dev.calmip.univ-toulouse.fr/#/repositories/",
    suffix: "/node/<http://www.callisto.calmip.univ-toulouse.fr/"
} 
function drawGraph() {
    cy = cytoscape({
        container: document.getElementById('cy'), // container to render in
        elements: [],

        style: [ // the stylesheet for the graph
        {
            selector: 'node',
            style: {
            'background-color': 'black',
            'label': 'data(label)',
            'shape': 'data(shape)'
            }
        },

        {
            selector: 'edge',
            style: {
            'width': 3,
            'line-color': 'blue',
            'target-arrow-color': 'blue',
            'target-arrow-shape': 'triangle',
            'curve-style': 'bezier'
            }
        },
        {
            selector: ".selectedservice",
            css: {
            "background-color": "green"
            }
        },
        {
            selector: ".donenode",
            css: {
            "background-color": "green"
            }
        },
        {
            selector: ".selectednode",
            css: {
            "background-color": "green"
            }
        },
	{
            selector: ".blackenedEdge",
            css: {
		"line-color": "black",
		"target-arrow-color": "black",
		"line-style": "dotted"
            }
        }
        ],
    });
    cy.mount(document.getElementById('cydetails'));
};


function Change_repository() {
    active_repo = document.querySelector("#repository").value;
}

function SeekOntology() {
    
    var repo = active_repo;
    var case1 = 'composition';
    chaine_args = 'info='+$("#QueryThis").val()+'&'+'repo='+repo;
    alert('info='+$("#QueryThis").val()+'&'+'repo='+repo);
    
    //Pour tests: chaine_args = 'info=magnitude&repo=demonstration'
    
    var remote=$.ajax({
	url: "/cgi-bin/Allegro_Workflows.py",
	method: 'POST',
	data:chaine_args,
	dataType: "text",
	success: handleSeekOntology
	});
}

function returnFromWorkflow() {
    activateLoadscreen()

    sadaResults.wrapper.classList.add('flex')
    sadaWorkflow.wrapper.classList.remove('flex')
    hideLoadscreen()
    hideGetFilesResultBox()
    
}

// onclick sem-search
function query_repository() {
    //
    var query = document.querySelector('#query').value
    var repo = active_repo;
    var researchType = document.querySelector('#research-type').value
    if (researchType == "composition") { // ???
	    SeekOntology();
    }
    else {
        var ajaxArgs = 'repo='+ repo + '&' + 'case='+ researchType + '&' + 'query='+ query + '&'
        console.log(ajaxArgs)
        //alert(chaine_args);
        var remote=$.ajax({
            url: "/cgi-bin/Allegro_Fcts.py",
            method: 'POST',
            data: ajaxArgs,
            dataType: "text",
            success: handleQueryArcadie
        });
    }
}
function BackToSearch() {
    activateLoadscreen();
    hideLoadscreen();
}
// onload sem-search
function handleQueryArcadie (request) {
    function fetchResults(){
        if (window.DOMParser) {
            parser = new DOMParser();
            xmlDoc = parser.parseFromString(request,"text/xml");

        }else{ // Internet Explorer                                                                                                                                                                                                        
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
            xmlDoc.async = "false";
            xmlDoc.loadXML(request);
        }
        return xmlDoc
    }

    semSearchResults.wrapper.classList.add('flex')
    hideLoadscreen()
    semSearchResults.container.innerHTML = ''

    var xmlDoc = fetchResults()
    var case_returned = xmlDoc.getElementsByTagName("case")[0].childNodes[0].nodeValue;
    allegro = xmlDoc.getElementsByTagName("allegro")[0].childNodes[0].nodeValue;
    suffix = xmlDoc.getElementsByTagName("suffix")[0].childNodes[0].nodeValue;
    var allegro = {
        prefix: allegro,
        suffix: "/node/<"+ suffix
    } 
    var x = xmlDoc.getElementsByTagName("service");

    if (x.length > 0) {
        appendElement(semSearchResults.container, 'h2', x.length + ' result(s) found', {'className': 'text--center m--b--2'})

        for (i = 0; i < x.length; i++) {

            switch (case_returned) {
                case 'generic': // bibliographic claims
                    statement = x[i].getElementsByTagName("statement")[0].childNodes[0].nodeValue;
                    claim = x[i].getElementsByTagName("claim")[0].childNodes[0].nodeValue;
                    citation = x[i].getElementsByTagName("citation")[0].childNodes[0].nodeValue;
                    url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
                    urldata = x[i].getElementsByTagName("urldata")[0].childNodes[0].nodeValue;
                    quals =  x[i].getElementsByTagName("qual");

                    var result = appendElement(semSearchResults.container, 'div', null, {'className': 'p--3 bg--light rounded inner-border flex flex--center flex--col m--b--1'})
                    appendElement(result, 'i', statement, {'className': 'm--b--1 text--center'})
                    var source = appendElement(result, 'p', null, {'className': 'm--b--1 text--small'})
                    appendElement(source, 'b', 'Source: ')
                    appendElement(source, 'span', citation)

                    appendElement(result, 'p', quals.length + ' related concept(s):')
                    var concepts = appendElement(result, 'div', null, {'className': 'm--b--1'})
                    for (qu = 0; qu < quals.length; qu++) {
                        var link = appendElement(concepts, 'a', null, {
                            'href': allegro.prefix + active_repo + allegro.suffix + active_repo + '.rdf%23' + quals[qu].childNodes[0].nodeValue + '>',
                            'target': '_BLANK'
                        })
                        appendElement(link, 'button', quals[qu].childNodes[0].nodeValue, {'className': 'bg--primary bg--img--none inner-border w--50'})
                    }

                    if (urldata != '"No Url attached"') {
                        appendElement(result, 'a', 'Download this document', {
                            'href': urldata,
                            'target': '_BLANK',
                            
                        })
                    } 

                    

                    if (i == 0) {
                        var addBtnWrapper = appendElement(semSearchResults.wrapper, 'div', null, {'className': 'pos--rel w--full'})
                        var addBtn = appendElement(addBtnWrapper, 'a', null, {
                            'className': 'flex flex--center unselectable pointer inner-border rounded p--x--1 side-btn r--0 pos--abs t--100 m--t--1 z--2 text--no-decoration m--r--3',
                            'href': 'abr.php'
                        })
                        addBtn.addEventListener('click', function() {
                            changePage(addBtn)
                        })
                        var p = appendElement(addBtn, 'p', null, {'className': 'm--r--05'})
                        appendElement(p, 'b', 'Add')
                        appendElement(addBtn, 'img', null, {'src': 'public/img/circle-plus.svg'})
                    }
                break

                case 'functionality': // software elements and functionalities
                    label = x[i].getElementsByTagName("label")[0].childNodes[0].nodeValue.slice(1,-1);
                    definition = x[i].getElementsByTagName("definition")[0].childNodes[0].nodeValue.slice(1,-1);
                    var charLimit = 120
                    definition.length < charLimit ? definition : definition.substring(0, charLimit) + '...' // UNTESTED
                    svc = x[i].getElementsByTagName("svc")[0].childNodes[0].nodeValue;

                    if (i == 0 || i % 2 == 0) {
                        var container = appendElement(semSearchResults.container, 'div', null, {'className': 'flex m--b--1'})
                        resultClassName = 'p--1 bg--light rounded inner-border flex flex--center flex--col w--50 m--r--1'
                    } else {
                        resultClassName = 'p--1 bg--light rounded inner-border flex flex--center flex--col w--50 m--l--1'
                    }
                    
                    var result = appendElement(container, 'div', null, {'className': resultClassName})
                    var labelElement = appendElement(result, 'p', null, {'className': 'm--b--1'})
                    appendElement(labelElement, 'b', label)
                    appendElement(result, 'p', definition, {'className': 'text--small m--b--1'})
                    var serviceLink = appendElement(result, 'a', null, {
                        'href': allegro.prefix + active_repo + allegro.suffix + active_repo + '.rdf%23' + svc + '>',
                        'target': '_BLANK'
                    })

                    appendElement(serviceLink, 'button', 'Learn more', {'className': 'bg--primary bg--img--none w--full'})
                break

                
                
                case 'getDetails':
                    $("#visuQuery").append("<div id=\"about\"></div>");
                    $("#about").html("");
                    if (x.length > 0) {
                        for (i=0;i<x.length;i++) {
                            statement = x[i].getElementsByTagName("statement")[0].childNodes[0].nodeValue;
                            publisher = x[i].getElementsByTagName("publisher")[0].childNodes[0].nodeValue;
                            description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;
                            datadesc = x[i].getElementsByTagName("datadesc")[0].childNodes[0].nodeValue;
                            $("#about").append("<b>Description of the service:</b><br/>"+description+"<br/>");
                            $("#about").append("<b>Service published by (when available):</b><br/>"+publisher+"<br/>");
                            $("#about").append("<b>Data coming from this service argues that (when applicable):</b><br/>"+statement+"<br/>");
                            $("#about").append("<b>Fine-grained description of the data (when available):</b><br/>"+datadesc+"<br/>");
                        }
                    }
                break

            
            }
        }       
    } else {
        appendElement(semSearchResults.container, 'h2', 'No results found', {'className': 'text--center m--b--2'})
    }    
}

// Onclick SADA Search button
function SeekInformation() {

    var query = document.querySelector('#information').value
    var case1 = "data";
    
    ajaxArgs = 'repo='+ active_repo + '&' + 'case='+ case1 + '&' + 'query='+ query + '&';
    
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:ajaxArgs,
        dataType: "text",
        success: handleSeekInformation
    });    

    loadscreen.title.textContent = "Now loading"
    loadscreen.subtitle.textContent = "This may take a few moments"
}

function handleSeekInformation(request)  {
    
    if (window.DOMParser) {
        parser=new DOMParser();
        xmlDoc=parser.parseFromString(request,"text/xml");

    } else { // Internet Explorer                                                                                                                                                                                                        
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(request);
    }
    var x=xmlDoc.getElementsByTagName("service");

    // DISPLAY

    hideLoadscreen();
    // Display results wrapper (display hidden by default)
    sadaResults.wrapper.classList.add('flex');
    sadaWorkflow.wrapper.classList.remove('flex');

    // Delete previous result(s)
    sadaResults.container.innerHTML = '';

    if (x.length > 0) {

        appendElement(sadaResults.container, 'h2', x.length + ' Result(s)', {'className': 'text--center m--b--2'})

        for (i=0;i<x.length;i++) {
			serviceId = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue.split('"')[1];
			try {
			soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue.replace("\"","");
			}
			catch (error){}
			try {
			url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
			}
			catch (error){}
			description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue.replace("b\'","").replace("\"","");

            var resultElement = appendElement(sadaResults.container, 'div', null, {
                'className': 'p--3 rounded flex flex--center result pointer m--b--1 inner-border',
                'id': serviceId
            })
            appendElement(resultElement, 'h4', serviceId.split("#")[1].replace("\"",""), {'className': 'w--25'})
            appendElement(resultElement, 'span', null, {'className': 'line m--x--1'})
            appendElement(resultElement, 'p', description, {'className': 'text--small'})

            resultElement.addEventListener('click', function(event) {
                event.preventDefault()
                activateLoadscreen()
                SeekOperations(this.id)
            })
		}
        $("#seekInfo").hide();
	} else {
		// no results
        appendElement(sadaResults.container, 'h2', 'No results found', {'className': 'text--center m--b--2'})
	}
}

// Onclick SADA result
function SeekOperations(dataset) {
    // var query = $("#information").val();
    var case1 = "seek_operations";
    var datasetLink = dataset
    var ajaxArgs = 'repo='+ active_repo + '&' + 'case='+ case1 + '&' + 'dataset='+ dataset + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data: ajaxArgs,
        dataType: "text",
        success: handleOperationsWorkflow
    });

    loadscreen.title.textContent = "Loading workflow"
    loadscreen.subtitle.textContent = "Just a few more seconds"

}
// load SADA workflows
// Critical file size issue: must be simplified using appendElement function
function allReset() {
    var nodes_graph = cy.nodes();
        for (i = 0; i < nodes_graph.length; i++) {
            nodes_graph[i].removeClass("selectednode");
        }
}
function allSet() {
    var nodes_graph = cy.nodes();
        for (i = 0; i < nodes_graph.length; i++) {
            nodes_graph[i].addClass("selectednode");
        }
}
function deselectEquivalents() {
    /*
    Deux noeuds sont les memes s'ils ont le meme voisinnage.
    Dans ce cas on devalide tous les equivalents en attente du choix utilisateur
    */
    var nodes_graph = cy.nodes();
        for (i = 0; i < nodes_graph.length; i++) {
            var cl = nodes_graph[i].classes();
           
            if (! cl.includes("selectednode")) {
                continue
            }
            
            var vois =  nodes_graph[i].neighborhood();
            for (j = 0; j < nodes_graph.length; j++) {
                if(i == j) {continue}
                var vois2 =  nodes_graph[j].neighborhood();
                console.log( 'same ? ' + vois.same(vois2) );
                if (vois.filter("nodes").same(vois2.filter("nodes"))) {
                    //On devalide les equivalents 
                    //on ne garde que le dernier par defaut
                    nodes_graph[j].removeClass("selectednode");
		    edges_toblack = nodes_graph.edgesWith(nodes_graph[j]);
		    //alert(edges_toblack);
		    for (tb = 0; tb < edges_toblack.length; tb++) {
			edges_toblack[tb].addClass("blackenedEdge");
		    }
                }
            }
        }
}
function handleOperationsWorkflow (request) {
     // INIT
     function fetchWorkflow() {
        if (window.DOMParser)
        {
            parser=new DOMParser();
            xmlDoc=parser.parseFromString(request,"text/xml");
        }else{ 
            xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
            xmlDoc.async="false";
            xmlDoc.loadXML(request);
        }
        
        explanations = ""
    }   
    
    fetchWorkflow()
    //clearPrevResults()
    
    drawGraph()
    $("#sada-wrapper").hide();
    $("#sada-workflow").show();
    
    hideLoadscreen()
    outputs_generaux = []
    tab_inout = []
    tab_inputs = []
    tab_outputs = []
    tab_urls = []
    tab_softs = []
    tab_definition = []
    tab_services = []
    tab_values = []
    tab_ontologies = []
    info_values = []
    allegro = xmlDoc.getElementsByTagName("allegro")[0].childNodes[0].nodeValue;
    suffix = xmlDoc.getElementsByTagName("suffix")[0].childNodes[0].nodeValue;
    var allegro = {
        prefix: allegro,
        suffix: "/node/<"+ suffix
    } 
    var x=xmlDoc.getElementsByTagName("service")
    var pos = 0
    if (x.length > 0) {
        for (i = 0; i < x.length; i++) {
            service_name = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
            input = x[i].getElementsByTagName("input")[0].childNodes[0].nodeValue;
            short_input = x[i].getElementsByTagName("short_input")[0].childNodes[0].nodeValue;
            input_definition = x[i].getElementsByTagName("input_definition")[0].childNodes[0].nodeValue;
            output =  x[i].getElementsByTagName("output")[0].childNodes[0].nodeValue;
            short_output = x[i].getElementsByTagName("short_output")[0].childNodes[0].nodeValue;
            output_definition = x[i].getElementsByTagName("output_definition")[0].childNodes[0].nodeValue;
            url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
            soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
            information_label = x[i].getElementsByTagName("information_label")[0].childNodes[0].nodeValue;
	        ontology_id = x[i].getElementsByTagName("ontology_id")[0].childNodes[0].nodeValue;
            definition =  x[i].getElementsByTagName("profdef")[0].childNodes[0].nodeValue;
            
            tab_services[i] = service_name;
            tab_urls[service_name] = url;
            tab_inputs[service_name] = short_input;
            tab_outputs[service_name] = short_output;
            outputs_generaux.push(short_output);
            tab_softs[service_name] = soft;
            console.log("register soft:",soft, " for ",service_name)
            info_values[input] = "";
            tab_inout[service_name] = ontology_id;
            tab_definition[service_name] = definition;
            tab_ontologies[service_name] = allegro.prefix + active_repo + "/node/<" + ontology_id;
            pos = i+1;
            if (! tab_inout.includes(input)) {
                tab_inout.push(input);
                tab_definition[input] = input_definition;
                tab_ontologies[input] = allegro.prefix + active_repo + allegro.suffix + active_repo + '.rdf%23' + input;
                cy.add([{ group: 'nodes', data: { id: input, label: input}, position: { x: pos*100, y: 100 }, isCircle: false }]);
            }
            if (! tab_inout.includes(output)) {
                tab_inout.push(output);
                tab_definition[output] = output_definition;
                if (output.includes("http:")) {
                    tab_ontologies[output] = allegro.prefix + active_repo + "/node/<" + output; }
                else {
                    tab_ontologies[output] = allegro.prefix + active_repo + allegro.suffix + active_repo + '.rdf%23' + output;
                }
                cy.add([{ group: 'nodes', data: { id: output, label: information_label}, position: { x: pos*100, y: 250 }, isCircle: false }]);
            }
            cy.add([ 
                { group: 'nodes', data: { id: service_name, label: service_name, shape: 'diamond'}, position: { x: pos*100, y: 150 } },
                { group: 'edges', data: { id: input+service_name, source: input, target: service_name }, style: {'background-color': 'white','border-color': 'blue'}},
                { group: 'edges', data: { id: service_name+output, source: service_name, target: output } }
            ]);
	    }
    }
    allSet();
    deselectEquivalents(); 
    cy.on('tap', 'node', function(evt) {
	var nodes_graph = cy.nodes();
        var node = evt.target;
        node.addClass("selectednode");
	if (node.style('shape') == "diamond") {
	    edges_tohighlight = nodes_graph.edgesWith(node);
	    for (th = 0; th < edges_tohighlight.length; th++) {
		edges_tohighlight[th].removeClass("blackenedEdge");
	    }
	}
        $("#cy").html(tab_definition[node.id()]);
        $("#cy").append("<br/><br/><a href='"+tab_ontologies[node.id()]+">'>Find out more</a>");
        var vois = node.neighborhood();
        for (i = 0; i < nodes_graph.length; i++) {
            if (node.id() == nodes_graph[i].id()){continue}
            var cl = nodes_graph[i].classes();
            if (! cl.includes("selectednode")) {
                continue
            }
            var vois2 =  nodes_graph[i].neighborhood();
            if (vois.filter("nodes").same(vois2.filter("nodes"))) {
                nodes_graph[i].removeClass("selectednode");
		edges_toblack = nodes_graph.edgesWith(nodes_graph[i]);
		for (tb = 0; tb < edges_toblack.length; tb++) {
		    edges_toblack[tb].addClass("blackenedEdge");
		}
            }
        }
      });
};
function AutomateServices() {
    var nodes_graph = cy.nodes();
    for (i = 0; i < nodes_graph.length; i++) {
            if (nodes_graph[i].hasClass("selectednode")) {
                service_name = nodes_graph[i].id();
                if (! tab_services.includes(service_name)) {continue}
                url = tab_urls[service_name];
                input = tab_inputs[service_name];
                var usrinput = 0;
                console.log("|"+input+"|");
                console.log(outputs_generaux);
                if ((!outputs_generaux.includes(input)) && (input != "void")) {usrinput = 1;}
                if(usrinput == 1){info_values[input]=prompt("user input required for"+input);}
                output = tab_outputs[service_name];
                soft = tab_softs[service_name];
                console.log("found soft:",soft, " for ",service_name)
                console.log(service_name,url,input,output,soft);
                ajaxArgs = '';
                ajaxArgs += input + '=' + info_values[input] + '&';
                ajaxArgs += 'url=' + url + '&';
                ajaxArgs += 'outputs=' + output;
                requestService(ajaxArgs, soft);
        }
    
    }
}

function requestService (chaine,software) {
    var remote=$.ajax({
        url: '/cgi-bin/'+software.replace("\"",""),
        method: 'POST',
        data: chaine,
        async: false,
        dataType: "text",
        success: handleServicesAutomation
    }); 
    
}
// onload getfiles
function handleServicesAutomation (request) {
    
    if (window.DOMParser) {
        parser = new DOMParser();
        xmlDoc = parser.parseFromString(request,"text/xml");
	
    }else{ // Internet Explorer                                                                                              
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(request);
    }
    var x = xmlDoc.getElementsByTagName("options");
    var result = x[0].getElementsByTagName(output)[0].childNodes[0].nodeValue;
    info_values[output]=result;
    var link = 'https://' + result;
    $("#cyresults").append("|");
    $("#cyresults").append("<a href='"+link+"'>"+output+"</a>");
    $("#cyresults").append("| ");
}

// onclick abr
function Register_publication() {
    //alert("entree dans register pblication");    
    var ajaxArgs = 'type=publication&';

        var user = document.querySelector('#abr-allegro-uid').value
        var password = document.querySelector('#abr-allegro-pwd').value
        var link = document.querySelector('#abr-link').value
        var authors = []
        var firstNames = document.querySelectorAll('.abr-first-name')
        var lastNames = document.querySelectorAll('.abr-last-name')
        var i = 0
    //alert("entree dans register pblication2");
       firstNames.forEach(firstName => {
            var author = firstName.value.charAt(0).toUpperCase() + firstName.value.substring(1) + ' ' + lastNames[i].value.charAt(0).toUpperCase() + lastNames[i].value.substring(1)
           //alert("author"+author) 
	   if (author.replace(/\s/g, '').length) { // filter authors that only contain white space (user-accidental)
                authors.push(author)
            }
            i++;
        })
    //alert("entree dans reg3");
        authors = authors.toString()
        var title = document.querySelector('#abr-title').value
        var ref = authors + '. ' + title

        var claims = []
        cl = $("#abr-claim").val();
        alert("claims jquery"+cl);
        var claimsElements = document.querySelectorAll('#abr-claim')
        claimsElements.forEach(claim => {
            if (claim.value != '') {
		alert("claim value:"+claim.value);
                claims.push(claim.value)
            }
        })
        // NEEDS TO BE TESTED: space and ampersand validation
        //var link = document.querySelector('#abr-link').replaceAll('&', 'and')

        var concepts = [] 
        var conceptsElements = document.querySelectorAll('.abr-concept')
        conceptsElements.forEach(concept => {
            concepts.push(concept.value)
        }) 
        //concepts = concepts.toString().replaceAll(',', '|').replaceAll('&', 'and');
    //alert("entree dans reg6");
       console.log(authors + ' ' + title + ' ' + claims + ' ' + link + ' ' + concepts + ' ' + user + ':' + password)
    //alert("Positionne les arguments");
        ajaxArgs += 'claim=' + claims + '&user=' + user + '&password=' + password + '&repo=' + active_repo + '&ref=' + ref + '&url=' + link + '&qual=' + concepts
        alert("Envoi du cgi enregistrement papier:"+ajaxArgs);
        var remote=$.ajax({
            url: "/cgi-bin/RegisterPublication.py",
            method: 'POST',
            data: ajaxArgs,
            dataType: "text",
	    async: false,
            success: handleRegisterPublication
      });
}

// onload abr
function handleRegisterPublication() {
    alert("Handle publication");
}

