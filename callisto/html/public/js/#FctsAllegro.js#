var active_repo = 'demonstration';
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
    prefix: "https://allegro.callisto.calmip.univ-toulouse.fr/#/repositories/",
    suffix: "/node/<http://www.callisto.calmip.univ-toulouse.fr/"
} 
// DOESN'T WORK
function ajaxReq(requestType, filePath, ajaxArgs) {
    var xhttp = new XMLHttpRequest()
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            handleServicesAutomation()
        }
    }
    xhttp.open(requestType /* GET or POST*/, filePath, true)
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8")
    xhttp.send(ajaxArgs)
}

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
    var x = xmlDoc.getElementsByTagName("service");

    // SIMPLIFY LOOPS WITHIN SWITCH
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
                            'href': allegro.prefix + active_repo + allegro.suffix + active_repo.toUpperCase() + '.rdf%23' + quals[qu].childNodes[0].nodeValue + '>',
                            'target': '_BLANK'
                        })
                        appendElement(link, 'button', quals[qu].childNodes[0].nodeValue, {'className': 'bg--primary bg--img--none inner-border w--50'})
                    }

                    if (urldata != '"No Url attached"') { // UNTESTED
                        appendElement(result, 'a', 'Download this document', {
                            'href': urldata,
                            'target': '_BLANK',
                            // uncomment when getDataClaim button is added
                            // 'className': 'm--b--1'
                        })
                    } else {
                        appendElement(result, 'p', 'No download links available', /*{
                            'className': 'm--b--1'
                        }*/) // uncomment when getDataClaim button is added
                    }

                    // getDataClaim button
                    // var getDataClaim = appendElement(result, 'button', 'Get relevant data', {'className': 'inner-border w--full'})
                    // getDataClaim.addEventListener('click', function(){
                    //     getDataClaim()
                    // })

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
                    //  FUNCTIONALITY'S DESCRIPTION MUST BE 120 CHARACTERS LONG MAX
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
                        'href': allegro.prefix + active_repo + allegro.suffix + active_repo.toUpperCase() + '.rdf%23' + svc + '>',
                        'target': '_BLANK'
                    })

                    appendElement(serviceLink, 'button', 'Learn more', {'className': 'bg--primary bg--img--none w--full'})
                break

                /*
                * OTHER CASES - NEED TO BE RECONFIGURED TO WORK ON SWITCH
                */

                // if (case_returned == "data") {
            //     $("#visuQuery").html("<h2>Here is a list of services that may be useful:</h2>")
            //     if (x.length > 0) {
            //         for (i=0;i<x.length;i++) {
            //             nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
            //             soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
            //             url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue; 
            //             description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue; 
            //             $("#visuQuery").append(nom+": <br/>"+description+"<br/><input type=\"button\"  onclick=\"getDetails(['"+nom+"']);\" value=\"Get details\"/>");
            //             if (soft == "get_dataset") {
            //                 $("#visuQuery").append("<br/>Data direct download: <a href='"+url+"'>Click HERE</a>")
            //             }
            //         }
            //     }
            // }

            // if (case_returned == "getDetails") {
            //     //alert("handling getDetails:"+x.length);
            //     $("#visuQuery").append("<div id=\"about\"></div>");
            //     $("#about").html("");
            //     if (x.length > 0) {
            //         for (i=0;i<x.length;i++) {
            //     //alert(i);
            //             statement = x[i].getElementsByTagName("statement")[0].childNodes[0].nodeValue;
            //             publisher = x[i].getElementsByTagName("publisher")[0].childNodes[0].nodeValue;
            //             description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;
            //             datadesc = x[i].getElementsByTagName("datadesc")[0].childNodes[0].nodeValue;
            //             //alert("<b>Description of the service:</b><br/>"+description+"<br/>");
            //             $("#about").append("<b>Description of the service:</b><br/>"+description+"<br/>");
            //             $("#about").append("<b>Service published by (when available):</b><br/>"+publisher+"<br/>");
            //             $("#about").append("<b>Data coming from this service argues that (when applicable):</b><br/>"+statement+"<br/>");
            //             $("#about").append("<b>Fine-grained description of the data (when available):</b><br/>"+datadesc+"<br/>");
            //         }
            //     }
            // }

            // if (case_returned == "about") {
            //     $("#visuQuery").append("<div id=\"about\"></div>");
            //     $("#about").html("");
            //     if (x.length > 0) {
            //         for (i=0;i<x.length;i++) {
            //             citation = x[i].getElementsByTagName("citation")[0].childNodes[0].nodeValue;
            //             publisher = x[i].getElementsByTagName("publisher")[0].childNodes[0].nodeValue;
            //             $("#about").append("<br/>This claim comes from the reference: "+citation+"<br/>");
            // 	        $("#about").append("<br/>Published by: "+publisher+"<br/>");
            //         }
            //     }
            // }

            // if (case_returned == "dataClaim") {
            //     $("#visuQuery").append("<div id=\"about\"></div>")
            //     $("#about").html("")
            //     var x=xmlDoc.getElementsByTagName("service")
            //     if (x.length > 0) {
            //         for (i=0;i<x.length;i++) {
            //             nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue
            //             description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue
            //             soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue
            //             url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue
            //             $("#about").append("<br/><b>A relevant dataset may be the following:</b><br/>"+description+"<br/>")
            //             inputs =  x[i].getElementsByTagName("input");
            //             $("#about").append("<br/>The data can be accessed by copy/pasting this link in your browser:<br/> "+url.replace("Callistodataverse:8080","https://dataverse.callisto.calmip.univ-toulouse.fr").replace("\"","").replace("\"","")+"YourCALLISTO_DataverseAPIToken");
            //         }
            //     }
            // }
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
// Load SADA results 
// MUST SIMPLIFY (appendElement)
function handleSeekInformation(request)  {
    // FETCH

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
    function clearPrevResults() {
        sadaWorkflow.container.innerHTML = ""
        sadaWorkflow.graph_inner.innerHTML = ""
    }
    function setupAppendInfo(service_name, ontology_id) {
        function getIO(IOarg) {
            var IO = x[i].getElementsByTagName(IOarg +"_definition");
            var IOs = []
            var IO_name
            if (IO.length > 0) {
                for (j = 0; j < IO.length; j++) {
                    IO_name = x[i].getElementsByTagName(IOarg)[j].childNodes[0].nodeValue
                    IOs.push({
                        url: allegro.prefix + active_repo + allegro.suffix + active_repo.toUpperCase() + '.rdf%23' + IO_name + '>',
                        link: document.createElement('a'),
                        name: document.createTextNode(IO_name),
                        icon: {
                            element: document.createElement('img'),
                            img: IOarg == 'input' ? 'arrow-up-circle-fill' : 'arrow-down-circle-fill'
                        },
                        IO_name: IO_name
                    })
                }
            }
            return IOs
        }
        function setupAppendIO(IOarg) {
            // manage inputs
            IOarg.forEach(element => {
                // icon
                element.icon.element.src = 'public/img/' + element.icon.img + '.svg'
                element.icon.element.className = 'm--r--05'
    
                // setup input link element
                element.link.appendChild(element.icon.element)
                element.link.appendChild(element.name)
                element.link.href = element.url
                element.link.target = "_BLANK"
                element.link.className = 'text--light m--r--2'
    
                // append input element to information
                information.element.appendChild(element.link)
            })
        }
    
        information = {
            element: document.createElement('div'),
            title: {
                string: document.createTextNode('\'s Information'),
                element: document.createElement('h3')
            },
            service : {
                url : allegro.prefix + active_repo + allegro.suffix + active_repo.toUpperCase() + ".rdf%23" + ontology_id + ">",
                link : document.createElement('a'),
                name : document.createTextNode(service_name)
            },
            output : getIO('output'),
            input : getIO('input'),
            description: {
                element: document.createElement('p'),
                content: document.createTextNode(x[i].getElementsByTagName("profdef")[0].childNodes[0].nodeValue+" ")
            }
        }

        // Setup block
        information.element.className = "swiper-slide m--y--0 m--l--2 m--r--0"

        // setup service link element
        information.service.link.appendChild(information.service.name)
        information.service.link.href = information.service.url
        information.service.link.target = "_BLANK"
        information.service.link.className = 'text--light'

        // setup title
        information.title.element.className = 'text--light m--t--3 m--b--1'
        information.title.element.appendChild(information.service.link)
        information.title.element.appendChild(information.title.string)

        // append information to sadaWorkflow div 
        sadaWorkflow.container.appendChild(information.element)
        // append title element to information
        information.element.appendChild(information.title.element)

        // manage IOs setup and append
        setupAppendIO(information.input)
        setupAppendIO(information.output)

        // setup description
        information.description.element.appendChild(information.description.content)
        information.description.element.className = "text--light w--80 m--t--1 info-tab__description"

        // append description
        information.element.appendChild(information.description.element)
    }
    function setupAppendGraph(sadaWorkflow) {
        function appendPreServiceArrow() {
            // arrow: only after first service
            if (i != 0) {
                preServiceArrow = appendElement(workflowGraph, 'div', null, {
                    'className': 'flex flex--align-center m--x--1 workflow__arrow--service'
                })
                appendElement(preServiceArrow, 'span', null, {
                    'className': 'bg--lisibility arrow--body rounded'
                })
                appendElement(preServiceArrow, 'span', null, {
                    'className': 'arrow--end'
                })
            }
        }
        function appendService() {
            serviceContainer = appendElement(workflowGraph, 'div', null, {
                'className': 'flex flex--col flex--center pointer'
            })
            // circle: first active by default
            if (i == 0) {
                appendElement(serviceContainer, 'span', null, {
                    'className': 'workflow__element workflow__element--service active'
                })
            } else {
                appendElement(serviceContainer, 'span', null, {
                    'className': 'workflow__element workflow__element--service'
                })
            }
            appendElement(serviceContainer, 'span', service_name, null)
        }
        function appendPreIOArrow() {
            preIOArrow = appendElement(workflowGraph, 'div', null, {
                'className': 'flex flex--align-center m--x--1 workflow__arrow--IO'
            })
            appendElement(preIOArrow, 'span', null, {
                'className': 'bg--lisibility arrow--body rounded'
            })
            appendElement(preIOArrow, 'span', null, {
                'className': 'arrow--end'
            })
        }
        function appendIO() {
            IOContainer = appendElement(workflowGraph, 'div', null, {
                'className': 'flex flex--col flex--center pointer'
            })
            appendElement(IOContainer, 'span', null, {
                'className': 'workflow__element workflow__element--IO'
            })
            appendElement(IOContainer, 'span', information.output[0].IO_name, null) 
        }
        function slideToInfo(trigger, slideIndex) {
            trigger.addEventListener('click', function() {
                swiper.slideTo(slideIndex)
            })
        }
        function setActiveService(trigger) {
            trigger.addEventListener('click', function() {
                previousActiveGraphic = document.querySelector('.workflow__element--service.active')
                // set graphic active
                trigger.children[0].classList.add('active')
                previousActiveGraphic.classList.remove('active')
    
            })
        }

        var workflowGraph = sadaWorkflow.graph_inner

        appendPreServiceArrow()        
        appendService()        
        appendPreIOArrow()        
        appendIO()        
    
        // Onclick service functions
        slideToInfo(serviceContainer, i)
        setActiveService(serviceContainer)
    }
    function manageOutputOverlap() {
        function checkAndPush(myArray, value) {
            if (!myArray.includes(value)) {
                myArray.push(value)
            }
        }
        function initVerticalContainer() {
            vertical_container = document.createElement('div')
            vertical_container.className = 'flex flex--col'
            workflowOutputArrow.parentNode.insertBefore(vertical_container, workflowOutputArrow)
    
            return vertical_container
        }

        var workflowOutputs = document.querySelectorAll('.workflow__element--IO')
        var workflowServices = document.querySelectorAll('.workflow__element--service')
        var workflowIOArrows = document.querySelectorAll('.workflow__arrow--IO')
        var workflowServiceArrows = document.querySelectorAll('.workflow__arrow--service')
        var thisOutput
        var matches = []
        for (var i = 0; i < workflowOutputs.length; i++) {
            // get name span
            thisOutput = workflowOutputs[i].nextSibling.textContent
            // add output to match list if not already
            if (matches[thisOutput] == undefined) {
                matches[thisOutput] = []
            }
            for (var j = i + 1; j < workflowOutputs.length; j++) {
                if (j < workflowOutputs.length) {
                    // if there are any outputs ahead that match
                    if (thisOutput == workflowOutputs[j].nextSibling.textContent) {
                        checkAndPush(matches[thisOutput], i)
                        checkAndPush(matches[thisOutput], j)
                    }   
                }
            }
        } 

        for (var output in matches) {
            i = 0
            matches[output].forEach(index => {
                i >= 1 ? workflowServiceArrow = workflowServiceArrows[index - 1] : workflowServiceArrow = null
                workflowServiceArrow = workflowServiceArrows[index]
                workflowService = workflowServices[index].parentElement
                workflowOutputArrow = workflowIOArrows[index]
                workflowOutput = workflowOutputs[index].parentElement

                // add vertical container in first place
                if (i == 0) {
                    vertical_container = initVerticalContainer()
                // don't remove first service arrow
                } else {
                    workflowServiceArrow.remove()
                    workflowOutputArrow.remove()
                    workflowOutput.remove()

                }
                workflowService.remove()

                // re append
                if (i != 0) {
                    appendElement(vertical_container, 'span', 'or', {
                        'className': 'm--y--1'
                    })
                }   
                vertical_container.appendChild(workflowService)
                
                i++;
                
            })      
        }
    }
    function manageGetFiles() {
        sadaWorkflow.get_files_form.innerHTML = ''

        tableau_urls = []
        var isoneok = 0;
        if (x.length > 0) {
            svcs_names = new Array(x.length);
            svcs_soft = new Array(x.length);
            svcs_inp = new Array(x.length);
            svcs_outp = new Array(x.length);
            output_values = new Array(x.length);
            for (i=0;i<x.length;i++)
            {
                nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
                svcs_names[i] = nom;
                output = x[i].getElementsByTagName("output");
                if (output.length > 0) {
                    outp = [];
                    for (j=0;j<output.length;j++) {
                        outp[j] = x[i].getElementsByTagName("output")[j].childNodes[0].nodeValue;
                    }
                }
                input = x[i].getElementsByTagName("input");
                if (input.length > 0) {
                    inp = [];
                    for (j=0;j<input.length;j++) {
                        inp[j] = x[i].getElementsByTagName("input")[j].childNodes[0].nodeValue;
                    }
                }
                    
                url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
                tableau_urls[i] = url;
                
                svcs_soft[i] = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue.replace('"',"");
                svcs_inp[i] = inp;
                svcs_outp[i] = outp;
                
                
                if (svcs_soft[i] != "NoSoft") {
                    for (j = 0; j < inp.length;j++) {
                        isoneok = 1;
			//alert("input required:" + inp[j]);
                        //if (inp[j]!="No input required") {
                        if (inp[j] == "ApiKeyValue") {

                            var p = appendElement(sadaWorkflow.get_files_form, 'p', 'A value is required for ', null)
                            appendElement(p, 'a', inp[j], {
                                'href': allegro.prefix + active_repo + allegro.suffix + active_repo.toUpperCase() + '.rdf%23' + inp[j] + '>',
                                'target': '_BLANK'
                            })
                            var get_files_input_container = appendElement(sadaWorkflow.get_files_form, 'div', null, {
                                'className': 'input-container w--80'
                            })
                            var get_files_input = appendElement(get_files_input_container, 'input', null, null)
                            get_files_input.type = 'text'
                            get_files_input.id = 'inp_' + inp[j]

                        } else if (inp[j] != "No input required") {

                            var get_files_input = appendElement(sadaWorkflow.get_files_form, 'input', null, null)
                            get_files_input.hidden = true
                            get_files_input.id = 'inp_' + inp[j]
                            
                            // sadaWorkflow.get_files_form.append("<div style=\"display:none\" id=div_" + inp[j] + "><input visibility=\"hidden\" type = 'text' id='inp_"+inp[j]+"'/></div>");
                        }
                        /*alert("in"+inp[j]);*/
                        for (k = 0; k < outp.length; k++) {
                        //alert("out"+outp[k]);
                            if (outp[k] == inp[j]) {
                                //This input may be automated: it is an output given by another service
                                sadaWorkflow.get_files_form.append("Leave this blank for automation<br/>");
                            }
                        }
                    }
                } 
            }
        }

        equivalents = [];
        match = 0;
        for (j = 0;j < svcs_inp.length; j++){
            for (l = 0; l < svcs_inp[j].length; l++){
                for (k = 0; k < svcs_outp.length; k++) {
                    for (m = 0; m < svcs_outp[k].length; m++) {
                        //alert(svcs_inp[j][l]+" vs. "+ svcs_outp[k][m]);
                        if (svcs_outp[k][m] == svcs_inp[j][l]) { 
                            //This input may be automated: it is an output given by another service                                                                                               
                            //$("#div_"+svcs_inp[j][l]).append("  Leave this to AUTO for automation (so that the value comes from another service in the workflow)");
                            document.querySelector('#inp_' + svcs_inp[j][l]).value = 'AUTO';
                        } 
                    }
                }
            
                for (k = 0; k < svcs_inp.length; k++) {
                    for (m = 0; m < svcs_inp[k].length; m++) {
                        //alert(svcs_inp[j][l]+" vs. "+ svcs_outp[k][m]);
                        if (svcs_inp[k][m] == svcs_inp[j][l]) { 
                        //This input may be automated: it is an output given by another service                                                                                               
                        //$("#div_"+svcs_inp[j][l]).append("  Leave this to AUTO for automation (so that the value comes from another service in the workflow)");
                            if(j != k) {
                                //alert("Found matching inputs between:"+svcs_names[j]+" and" +svcs_names[k]);
                                for (sortie1 = 0; sortie1 < svcs_outp[j].length; sortie1++) {
                                    //alert("output from:"+svcs_names[j]+" is: "+svcs_outp[j][sortie1]);
                                    for (sortie2 = 0; sortie2 < svcs_outp.length; sortie2++) {
                                        if (j == sortie2) {continue} else{
                                            for (sortie3 =0; sortie3 < svcs_outp[sortie2].length; sortie3++) {
                                                //alert("output from:"+svcs_names[sortie2]+" is "+svcs_outp[sortie2][sortie3]);
                                                if (svcs_outp[sortie2][sortie3] == svcs_outp[j][sortie1]) {
                                                    //alert(svcs_names[sortie2]+ " et "+ svcs_names[j]+" sont équivalents");
                                                    if (match == 0) {
                                                        appendElement(sadaWorkflow.get_files_form, 'label', 'Select a method:', null)
                                                        var select = appendElement(sadaWorkflow.get_files_form, 'select', null, {
                                                            'className': 'w--80 m--b--1'
                                                        })
                                                        // PROBLEM: By using id there can only be one select
                                                        select.id = 'workflow-choice'
                                                        match = 1
                                                    }
                                                    if(!equivalents.includes(j)) {
                                                        equivalents.push(j)
                                                        option = appendElement(select, 'option', 'S' + j, null)
                                                        option.value = j
                                                    }
                                                    if(!equivalents.includes(sortie2)) {
                                                        equivalents.push(sortie2);
                                                        option = appendElement(select, 'option', 'S' + sortie2, null)
                                                        option.value = sortie2
                                                    }
                                                    //alert(equivalents);
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }    
                    }
                }
            }
        }	

        if (isoneok == 1) {
            button = appendElement(sadaWorkflow.get_files_form, 'button', 'Go', {
                'className': 'inner-border',
            })
            button.addEventListener('click', function(event) {
                event.preventDefault()
                showLoadAnimation()
                setTimeout(function(){
                    AutomateServices()
                }, 100)
            })
        }
    }

    // EXEC
    fetchWorkflow()
    hideLoadscreen()
    clearPrevResults()

    // hide SADA results and display workflow
    sadaResults.wrapper.classList.remove('flex')
    sadaWorkflow.wrapper.classList.add('flex')

    var x=xmlDoc.getElementsByTagName("service")
    if (x.length > 0) {
        for (i = 0; i < x.length; i++) {
            service_name = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue
	        ontology_id = x[i].getElementsByTagName("ontology_id")[0].childNodes[0].nodeValue

            setupAppendInfo(service_name, ontology_id)            
            setupAppendGraph(sadaWorkflow)
	    }
        swiper.update()
        manageOutputOverlap()      
        manageGetFiles()  
    }
    

    //     }}

    // tableau_urls = []
    // smth = document.createElement('div')
    // smth.id = 'genericflow'
    // sadaWorkflow.graph_inner.append(smth);
    // general_csv = xmlDoc.getElementsByTagName("csvschemafile")[0].childNodes[0].nodeValue;
    // displayGraph("https://callisto.calmip.univ-toulouse.fr/TempFiles/"+general_csv,"genericflow");
}

// onclick getfiles
function AutomateServices() {
    function cleanPrevResults(){
        document.querySelectorAll('#get-files-results img').forEach(element => {
            element.remove()
        }) 
        // DOESN'T WORK BECAUSE OF AJAX REQUEST'S LAG
        hideGetFilesResultBox()
    }

    cleanPrevResults()

    setTimeout(function() {
        console.log('a')
    }, 1000)

    for (s_to_call = 0; s_to_call <= (svcs_soft.length) - 1; s_to_call++) {
        ajaxArgs = ''
        if(!equivalents.includes(s_to_call) || s_to_call == document.querySelector('#workflow-choice').value) {
                // this adds "Loading service" next to the loading animation
                // For some reason, it doesn't work until last iteration
            // document.querySelector('#animation-service').innerHTML = 'Loading ' + svcs_names[s_to_call]
                // You may use the following alert if the user needs to know the request's progress
            // alert(svcs_names[s_to_call]);

            current_outputs = []
            for (k = 0; k < svcs_outp[s_to_call].length; k++) {
                current_outputs[k] = svcs_outp[s_to_call][k]
            }
            
            for (k = 0; k < svcs_inp[s_to_call].length; k++) {
            //alert(svcs_inp[s_to_call][k]);
                ajaxArgs += svcs_inp[s_to_call][k] + '=' + document.querySelector('#inp_' + svcs_inp[s_to_call][k]).value + '&'
            }
            
            ajaxArgs += 'url=' + tableau_urls[s_to_call] + '&'
            var outputs = ""
            for (k = 0; k < svcs_outp[s_to_call].length; k++){
                if (k== (svcs_outp[s_to_call].length -1)) {
                    outputs += svcs_outp[s_to_call][k] 
                } 
                else {
                    outputs += svcs_outp[s_to_call][k] + ","
                }                                                                                        
            }
            ajaxArgs += 'outputs=' + outputs;

            var remote=$.ajax({
                url: '/cgi-bin/'+svcs_soft[s_to_call].replace("\"",""),
                method: 'POST',
                data: ajaxArgs,
                async: false,
                dataType: "text",
                success: handleServicesAutomation
            });     
        } 
    }
    removeLoadAnimation()
    document.querySelector('#get-files-results.hidden').classList.replace('hidden', 'open')
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

    for (k = 0; k < current_outputs.length; k++) {
        try {
            for (nb = 0; nb < x[0].getElementsByTagName(current_outputs[k]).length; nb++) {
                var result = x[0].getElementsByTagName(current_outputs[k])[nb].childNodes[0].nodeValue; 
                // if ($("#inp_"+current_outputs[k]).val() == "AUTO") {
                    // $("#inp_"+current_outputs[k]).val(result);
                    // if (result.includes("http")) {
                var link = appendElement(sadaWorkflow.get_files_results, 'a')
                link.href = 'https://' + result
                link.target = '_BLANK'

                var result_components = result.split('.')
                var file_extension = result_components[result_components.length - 1]
                if (extensions.img.includes(file_extension)) {
                    
                    appendElement(link, 'img', null, {
                        'src': 'public/img/file-image-solid.svg',
                        'className': 'getfiles-icon'
                    })
                    
                } else if (extensions.table.includes(file_extension)) {

                    if (file_extension == 'csv') {
                        appendElement(link, 'img', null, {
                            'src': 'public/img/file-csv-solid.svg',
                            'className': 'getfiles-icon'
                        })
                    } else {
                        appendElement(link, 'img', null, {
                            'src': 'public/img/table-solid.svg',
                            'className': 'getfiles-icon'
                        })
                    }

                } else {

                    appendElement(link, 'img', null, {
                        'src': 'public/img/file-alt-solid.svg',
                        'className': 'getfiles-icon'
                    })

                }
                
                    // }
                // } else {
                //     //alert("Final result (or result for a non automated field) is:"+result+" for "+current_outputs[k])
                //     $("#available_wflows").append("<br/>"+current_outputs[k]+": <a href='https://"+result+"' target='_blank'>"+result+"</a>");
                // }
            
                for (j=0;j<svcs_inp.length;j++){
                    for (l=0;l<svcs_inp[j].length;l++){
                        //alert(svcs_inp[j][l]+" vs. "+ current_outputs[k]);
                        if (current_outputs[k] == svcs_inp[j][l]) { 
                            //This input may be automated: it is an output given by another service
                            //alert("this output is an input and value is: "+result);
                            $("#inp_"+svcs_inp[j][l]).val(result);
                        }  
                    }
                }	
		    }
        } catch (error) {
            console.error(error);
            continue;
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

