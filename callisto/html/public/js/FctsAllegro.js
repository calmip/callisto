var active_repo = 'sms';
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
    cy.mount(document.getElementById('cy'));
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
    //activateLoadscreen()

    //sadaResults.wrapper.classList.add('flex')
    //sadaWorkflow.wrapper.classList.remove('flex')
    //hideLoadscreen()
    //hideGetFilesResultBox()
    
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
    //activateLoadscreen();
    //hideLoadscreen();
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
    //hideLoadscreen()
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
    var case1 = "seek_operations";
    
    ajaxArgs = 'repo='+ active_repo + '&' + 'case='+ case1 + '&' + 'query='+ query + '&';
    $("#cy").html("Please wait... Workflow composition running.");
    $("body").css("cursor", "progress");
    $("#seekInfo").hide();
    $("#getRes").hide();
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:ajaxArgs,
        dataType: "text",
        success: handleOperationsWorkflow
    });    

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
	    if (nodes_graph[i].style('shape') != "diamond") {
                    continue
                }

            var cl = nodes_graph[i].classes();
            if (! cl.includes("selectednode")) {
                continue
            }
            console.log("testing i:"+nodes_graph[i].style('label'));
            var vois =  nodes_graph[i].neighborhood();
            //modif 26Jan pour selection de services par defaut
	      for (j = 0; j < nodes_graph.length; j++) {
		if (i == j) {
		  continue    
		}
		//console.log("Counting outgoers");
		//Si deux noeuds ont un edge qui a un meme successeur on devalide un des noeuds
		if (nodes_graph[j].style('shape') != "diamond") {
		    continue
		}
		var jcl = nodes_graph[j].classes();
		if (! jcl.includes("selectednode")) {
                    continue
		}
		console.log("testing j:"+nodes_graph[j].style('label'));
		outgo = nodes_graph[i].outgoers();
		outgo2 = nodes_graph[j].outgoers();
		for (o1 = 0; o1 < outgo.length; o1 ++) {
		    for (o2 = 0; o2 < outgo2.length; o2 ++) {
			console.log("is node:"+outgo2[o2].isNode());
			console.log("label:"+outgo2[o2].style('label'));
			if ((outgo2[o2].isNode())) {
			    if((outgo[o1].isNode())) {
				console.log("outgo 1:"+outgo[o1].style('label'));
				if (outgo2[o2].same(outgo[o1])) {
				    console.log("same target detected");
				    nodes_graph[j].removeClass("selectednode");
				    edges_toblack = nodes_graph.edgesWith(nodes_graph[j]);
				    for (tb = 0; tb < edges_toblack.length; tb++) {
					edges_toblack[tb].addClass("blackenedEdge");
				    }
				    
				}
			    }
			}
			
		    }
		}
        }
    }
}
function handleOperationsWorkflow (request) {
     // INIT
    $("#cy").html(""); 
    $("body").css("cursor", "default");
    $("#seekInfo").show();
    $("#getRes").show();
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
    
    //hideLoadscreen()
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
            input = x[i].getElementsByTagName("input");
	    output =  x[i].getElementsByTagName("output");
	    	    
	    url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
            soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
            information_label = x[i].getElementsByTagName("information_label")[0].childNodes[0].nodeValue;
	    ontology_id = x[i].getElementsByTagName("ontology_id")[0].childNodes[0].nodeValue;
            definition =  x[i].getElementsByTagName("profdef")[0].childNodes[0].nodeValue;
            tab_urls[service_name] = url;
	    tab_services[i] = service_name;
	    tab_softs[service_name] = soft;
            console.log("register soft:",soft, " for ",service_name);
	    tab_inout[service_name] = ontology_id;
            tab_definition[service_name] = definition;
            tab_ontologies[service_name] = allegro.prefix + active_repo + "/node/<" + ontology_id;
	    tab_inputs[service_name] = [];
            tab_outputs[service_name] = [];

	    cy.add([{ group: 'nodes', data: { id: service_name, label: service_name, shape: 'diamond'}, position: { x: pos*100, y: 150 } }]);
            

	    for (input_count = 0; input_count < input.length; input_count ++) { 
		short_input = x[i].getElementsByTagName("short_input")[input_count].childNodes[0].nodeValue;
		current_input_definition = x[i].getElementsByTagName("input_definition")[input_count].childNodes[0].nodeValue;
		current_input = input[input_count].childNodes[0].nodeValue;
		if (! tab_inputs[service_name].includes(short_input)) {
		    tab_inputs[service_name].push(short_input);
		}
		info_values[current_input] = "";
		pos = i+1;
		if (! tab_inout.includes(current_input)) {
                    tab_inout.push(current_input);
                    tab_definition[current_input] = current_input_definition;
                    tab_ontologies[current_input] = allegro.prefix + active_repo + allegro.suffix + active_repo + '.rdf%23' + current_input;
                    cy.add([{ group: 'nodes', data: { id: current_input, label: current_input}, position: { x: pos*100+input_count, y: 100 }, isCircle: false }]);
		}
		cy.add([{ group: 'edges', data: { id: current_input+service_name, source: current_input, target: service_name }, 
			  style: {'background-color': 'white','border-color': 'blue'}}]);

		}
		for (output_count = 0; output_count < output.length; output_count ++) {
		    current_output =  x[i].getElementsByTagName("output")[output_count].childNodes[0].nodeValue;
		    short_output = x[i].getElementsByTagName("short_output")[output_count].childNodes[0].nodeValue;
		    output_definition = x[i].getElementsByTagName("output_definition")[output_count].childNodes[0].nodeValue;
		    if (! tab_outputs[service_name].includes(short_output)) {
			tab_outputs[service_name].push(short_output);
		    }
		    if (! outputs_generaux.includes(short_output)) { 
			outputs_generaux.push(short_output);
			}
		  if (! tab_inout.includes(current_output)) {
                    tab_inout.push(current_output);
                    tab_definition[current_output] = output_definition;
                    if (current_output.includes("http:")) {
			tab_ontologies[current_output] = allegro.prefix + active_repo + "/node/<" + current_output; }
                    else {
                    tab_ontologies[current_output] = allegro.prefix + active_repo + allegro.suffix + active_repo+ '.rdf%23' + current_output;
                    }
                    cy.add([{ group: 'nodes', data: { id: current_output, label: information_label}, position: { x: pos*100+output_count, y: 250 }, isCircle: false }]);
		}
		cy.add([ 
                    { group: 'edges', data: { id: service_name+current_output, source: service_name, target: current_output }}]);
	      }
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
        $("#sem_information").html(tab_definition[node.id()]);
        $("#sem_information").append("<br/><br/><a href='"+tab_ontologies[node.id()]+">'>Find out more</a><br/><br/>");
        var vois = node.neighborhood();
        
	/*for (i = 0; i < nodes_graph.length; i++) {
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
        }*/
	for (i = 0; i < nodes_graph.length; i++) {
                if (node.id() == nodes_graph[i].id()){continue}
                //Si deux noeuds ont un edge qui a un meme successeur on devalide un des noeuds                                                 
                if (nodes_graph[i].style('shape') != "diamond") {
                    continue
                }
                var jcl = nodes_graph[i].classes();
                if (! jcl.includes("selectednode")) {
                    continue
                }
                console.log("testing i:"+nodes_graph[i].style('label'));
                outgo = node.outgoers();
                outgo2 = nodes_graph[i].outgoers();
                for (o1 = 0; o1 < outgo.length; o1 ++) {
                    for (o2 = 0; o2 < outgo2.length; o2 ++) {
                        console.log("is node:"+outgo2[o2].isNode());
                        console.log("label:"+outgo2[o2].style('label'));
                        if ((outgo2[o2].isNode())) {
                            if((outgo[o1].isNode())) {
                                console.log("outgo 1:"+outgo[o1].style('label'));
                                if (outgo2[o2].same(outgo[o1])) {
                                    console.log("same target detected");
                                    nodes_graph[i].removeClass("selectednode");
                                    edges_toblack = nodes_graph.edgesWith(nodes_graph[i]);
                                    for (tb = 0; tb < edges_toblack.length; tb++) {
                                        edges_toblack[tb].addClass("blackenedEdge");
                                    }

                                }
                            }
                        }

                    }
                }
        }

      });
    
    var layout = cy.layout({
	
	name: 'breadthfirst',
	
	fit: true, // whether to fit the viewport to the graph
	directed: false, // whether the tree is directed downwards (or edges can point in any direction if false)
	padding: 30, // padding on fit
	circle: false, // put depths in concentric circles if true, put depths top down if false
	grid: false, // whether to create an even grid into which the DAG is placed (circle:false only)
	spacingFactor: 1.75, // positive spacing factor, larger => more space between nodes (N.B. n/a if causes overlap)
	boundingBox: undefined, // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
	avoidOverlap: true, // prevents node overlap, may overflow boundingBox if not enough space
	nodeDimensionsIncludeLabels: false, // Excludes the label when calculating node bounding boxes for the layout algorithm
	roots: undefined, // the roots of the trees
	maximal: false, // whether to shift nodes down their natural BFS depths in order to avoid upwards edges (DAGS only)
	depthSort: undefined, // a sorting function to order nodes at equal depth. e.g. function(a, b){ return a.data('weight') - b.data('weight') }
	animate: false, // whether to transition the node positions
	animationDuration: 500, // duration of animation in ms if enabled
	animationEasing: undefined, // easing of animation if enabled,
	animateFilter: function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
	ready: undefined, // callback on layoutready
	stop: undefined, // callback on layoutstop
	transform: function (node, position ){ return position; } // transform a given node position. Useful for changing flow direction in discrete layouts
    });
    layout.run();
    
};
function Toggle_layout (lay) {
    if (lay == 1) {
	var layout = cy.layout({
            name: 'breadthfirst',
            fit: true, // whether to fit the viewport to the graph
	    directed: false, // whether the tree is directed downwards (or edges can point in any direction if false)                                                                                      
            padding: 30, // padding on fit                                                                                                   
            circle: false, // put depths in concentric circles if true, put depths top down if false                              
            grid: false, // whether to create an even grid into which the DAG is placed (circle:false only)                              
            spacingFactor: 1.75, // positive spacing factor, larger => more space between nodes (N.B. n/a if causes overlap)                             
            boundingBox: undefined, // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }                                                                                           
            avoidOverlap: true, // prevents node overlap, may overflow boundingBox if not enough space                                                                     
            nodeDimensionsIncludeLabels: false, // Excludes the label when calculating node bounding boxes for the layout algorithm                          
            roots: undefined, // the roots of the trees                                                                                                                         
            maximal: false, // whether to shift nodes down their natural BFS depths in order to avoid upwards edges (DAGS only)                                       
            depthSort: undefined, // a sorting function to order nodes at equal depth. e.g. function(a, b){ return a.data('weight') - b.data('weight') }       
            animate: false, // whether to transition the node positions                                                                                                             
            animationDuration: 500, // duration of animation in ms if enabled                                                                                                 
            animationEasing: undefined, // easing of animation if enabled,                                                 
            animateFilter: function ( node, i ){ return true; },
	    ready: undefined,
	    stop: undefined,                                                                                                                                                       
            transform: function (node, position ){ return position; } // transform a given node position. Useful for changing flow direction in discrete layouts                                               
	});
	layout.run();
    } else if (lay == 2) {
	var layout = cy.layout({
	    name: 'circle',

	    fit: true, // whether to fit the viewport to the graph
	    padding: 30, // the padding on fit
	    boundingBox: undefined, // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
	    avoidOverlap: true, // prevents node overlap, may overflow boundingBox and radius if not enough space
	    nodeDimensionsIncludeLabels: false, // Excludes the label when calculating node bounding boxes for the layout algorithm
	    spacingFactor: undefined, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
	    radius: undefined, // the radius of the circle
	    startAngle: 3 / 2 * Math.PI, // where nodes start in radians
	    sweep: undefined, // how many radians should be between the first and last node (defaults to full circle)
	    clockwise: true, // whether the layout should go clockwise (true) or counterclockwise/anticlockwise (false)
	    sort: undefined, // a sorting function to order the nodes; e.g. function(a, b){ return a.data('weight') - b.data('weight') }
	    animate: false, // whether to transition the node positions
	    animationDuration: 500, // duration of animation in ms if enabled
	    animationEasing: undefined, // easing of animation if enabled
	    animateFilter: function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
	    ready: undefined, // callback on layoutready
	    stop: undefined, // callback on layoutstop
	    transform: function (node, position ){ return position; } // transform a given node position. Useful for changing flow direction in discrete layouts 
	    
	});
	layout.run();
    } else if (lay == 3) {
        var layout = cy.layout({
            name: 'concentric',
	    fit: true, // whether to fit the viewport to the graph
	    padding: 30, // the padding on fit
	    startAngle: 3 / 2 * Math.PI, // where nodes start in radians
	    sweep: undefined, // how many radians should be between the first and last node (defaults to full circle)
	    clockwise: true, // whether the layout should go clockwise (true) or counterclockwise/anticlockwise (false)
	    equidistant: true, // whether levels have an equal radial distance betwen them, may cause bounding box overflow
	    minNodeSpacing: 10, // min spacing between outside of nodes (used for radius adjustment)
	    boundingBox: undefined, // constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
	    avoidOverlap: true, // prevents node overlap, may overflow boundingBox if not enough space
	    nodeDimensionsIncludeLabels: false, // Excludes the label when calculating node bounding boxes for the layout algorithm
	    height: undefined, // height of layout area (overrides container height)
	    width: undefined, // width of layout area (overrides container width)
	    spacingFactor: undefined, // Applies a multiplicative factor (>0) to expand or compress the overall area that the nodes take up
	    concentric: function( node ){ // returns numeric value for each node, placing higher nodes in levels towards the centre
		return node.degree();
	    },
	    levelWidth: function( nodes ){ // the variation of concentric values in each level
		return nodes.maxDegree() / 4;
	    },
	    animate: false, // whether to transition the node positions
	    animationDuration: 500, // duration of animation in ms if enabled
	    animationEasing: undefined, // easing of animation if enabled
	    animateFilter: function ( node, i ){ return true; }, // a function that determines whether the node should be animated.  All nodes animated by default on animate enabled.  Non-animated nodes are positioned immediately when the layout starts
	    ready: undefined, // callback on layoutready
	    stop: undefined, // callback on layoutstop
	    transform: function (node, position ){ return position; } 
        });
	layout.run();
    } else if (lay == 4) {
	var layout = cy.layout({
	    name: 'cose',
	    // Called on `layoutready`
	    ready: function(){},
	    
	    // Called on `layoutstop`
	    stop: function(){},
	    
	    // Whether to animate while running the layout
	    // true : Animate continuously as the layout is running
	    // false : Just show the end result
	    // 'end' : Animate with the end result, from the initial positions to the end positions
	    animate: true,
	    
	    // Easing of the animation for animate:'end'
	    animationEasing: undefined,
	    
	    // The duration of the animation for animate:'end'
	    animationDuration: undefined,
	    
	    // A function that determines whether the node should be animated
	    // All nodes animated by default on animate enabled
	    // Non-animated nodes are positioned immediately when the layout starts
	    animateFilter: function ( node, i ){ return true; },
	    
	    
	    // The layout animates only after this many milliseconds for animate:true
	    // (prevents flashing on fast runs)
	    animationThreshold: 250,
	    
	    // Number of iterations between consecutive screen positions update
	    refresh: 20,
	    
	    // Whether to fit the network view after when done
	    fit: true,
	    
	    // Padding on fit
	    padding: 30,
	    
	    // Constrain layout bounds; { x1, y1, x2, y2 } or { x1, y1, w, h }
	    boundingBox: undefined,
	    
	    // Excludes the label when calculating node bounding boxes for the layout algorithm
	    nodeDimensionsIncludeLabels: false,
	    
	    // Randomize the initial positions of the nodes (true) or use existing positions (false)
	    randomize: false,
	    
	    // Extra spacing between components in non-compound graphs
	    componentSpacing: 40,
	    
	    // Node repulsion (non overlapping) multiplier
	    nodeRepulsion: function( node ){ return 2048; },
	    
	    // Node repulsion (overlapping) multiplier
	    nodeOverlap: 4,
	    
	    // Ideal edge (non nested) length
	    idealEdgeLength: function( edge ){ return 32; },
	    
	    // Divisor to compute edge forces
	    edgeElasticity: function( edge ){ return 32; },
	    
	    // Nesting factor (multiplier) to compute ideal edge length for nested edges
	    nestingFactor: 1.2,
	    
	    // Gravity force (constant)
	    gravity: 1,
	    
	    // Maximum number of iterations to perform
	    numIter: 1000,
	    
	    // Initial temperature (maximum node displacement)
	    initialTemp: 1000,
	    
	    // Cooling factor (how the temperature is reduced between consecutive iterations
	    coolingFactor: 0.99,
	    
	    // Lower temperature threshold (below this point the layout will end)
	    minTemp: 1.0
	});
	layout.run();
    }

    
}
function freeze_commands() {
    $("#seekInfo").hide();
    $("#getRes").hide();
    $("body").css("cursor", "progress");
}
function release_commands() {
    $("#seekInfo").show();
    $("#getRes").show();
    $("body").css("cursor", "default");
}

function AutomateServices() {
    
    //Etablir la liste des services a appeler
    var svc_to_call = [];
    var nodes_graph = cy.nodes();
    for (i = 0; i < nodes_graph.length; i++) {
            if (nodes_graph[i].hasClass("selectednode")) {
                service_name = nodes_graph[i].id();
                if (! tab_services.includes(service_name)) {
		    continue
		}
		else{
		    svc_to_call.push(service_name);
		}
	    }
    }
    //Si aucun des inputs n'est un output d'un autre service ou si tous les inputs sont connus
    // on appelle le service
    var left_calling = 1;
    var called = [];
    for (run_svc = 0; run_svc < svc_to_call.length; run_svc ++){        
            service_name = svc_to_call[run_svc];
            input = tab_inputs[service_name];
            for (individual_input = 0; individual_input < input.length; individual_input ++) {
                info_values[input[individual_input]] ="";
	    }
    }
    left_calling = svc_to_call.length;
    while (left_calling > 0) {
	for (run_svc = 0; run_svc < svc_to_call.length; run_svc ++){
	    ajaxArgs = '';
	    service_name = svc_to_call[run_svc];
	    //Si le service a deja ete appele on passe
	    if (service_name in called) {
		continue
	    }
	    console.log("testing calling of: "+service_name);
	    var missing_info = 0;
	    input = tab_inputs[service_name];
	    console.log(input);
	    for (individual_input = 0; individual_input < input.length; individual_input ++) {
		//que inputs est un output d'un autre service? quel input vient de l'utilisateur?
		console.log("Testing:" + input[individual_input]);
		if (info_values[input[individual_input]] =="") {
                    missing_info = 1;
		    console.log("Missing information:"+input[individual_input]);                                                   
		    if (!outputs_generaux.includes(input[individual_input])) {
			info_values[input[individual_input]]=prompt("user input required for"+input[individual_input]);
			ajaxArgs += input[individual_input] + '=' + info_values[input[individual_input]] + '&';
			missing_info =0;
		    }
		} else {
		    ajaxArgs += input[individual_input] + '=' + info_values[input[individual_input]] + '&';
		}
	    }
	    //Si aucun des inputs n'est un output d'un autre service ou si tous les inputs sont connus                                                 
            // on appelle le service
	    if ((! missing_info)) {
		if (called.includes(service_name)) {
		    console.log("Service "+service_name+" already called");
		} else {
		    console.log("calling service:"+service_name);
		    called.push(service_name);
		    left_calling -= 1;
		    //alert("reste a appeler: "+left_calling);
		    for (out_retrieve = 0; out_retrieve < tab_outputs[service_name].length; out_retrieve ++) {
			ajaxArgs += 'outputs=' + tab_outputs[service_name][out_retrieve]+ '&';
		    }
		    active_service = service_name;
		    soft = tab_softs[service_name];
		    ajaxArgs += 'url=' + tab_urls[service_name] + '&';
		    requestService(ajaxArgs, soft);        
		}
	    } else {
		//On attend que le service ait assez d'info en input disponible pour le lancer
		if (left_calling == 1) {
		    //Impossible de lancer le dernier service: on abandonne.
		    left_calling = 0
		    console.log("Withdrawing call to "+service_name+" due to lack of information");
		}
	    }
	    
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
    console.log("handling return of:"+active_service);
    for (out_retrieve = 0; out_retrieve < tab_outputs[active_service].length; out_retrieve ++) {
	//initialise les valeurs avec des valeurs par défaut
	info_values[tab_outputs[active_service][out_retrieve]] = "default return value";
    }
    x = xmlDoc.getElementsByTagName("options");
    console.log(x[0]);
    for (out_retrieve = 0; out_retrieve < tab_outputs[active_service].length; out_retrieve ++) {
	console.log("parsing:"+tab_outputs[active_service][out_retrieve]);
	result = x[0].getElementsByTagName(tab_outputs[active_service][out_retrieve])[0].childNodes[0].nodeValue;
         info_values[tab_outputs[active_service][out_retrieve]] = result;
    
    console.log("updating result:"+ tab_outputs[active_service][out_retrieve]+" with " +result);
    var link = 'https://' + result;
    $("#linktoresults").append("<br/>");
    if (link.includes(".png")) {
	$("#linktoresults").append("<a href='"+link+"'>"+tab_definition[tab_outputs[active_service][out_retrieve]]+"<img src=\""+link+"\" width=\"100\" height = \"100\"></a>");
    } 
    else {
	$("#linktoresults").append("<a href='"+link+"'>"+tab_definition[tab_outputs[active_service][out_retrieve]]+"</a>");
    }
    }
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

