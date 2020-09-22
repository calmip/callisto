function SeekOntology() {
    alert("Your request for "+$("#IWantThis").val()+" is being processed. You will receive a new message when result and explanation are available. This may last a few minutes...");
    chaine_args = 'info='+ $("#QueryThis").val()+'&';
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    var case1 = 'composition';
    chaine_args += 'repo='+repo+'&case='+case1;
    var remote=$.ajax({
	url: "/cgi-bin/Callisto_sparql2.py",
	method: 'POST',
	data:chaine_args,
	dataType: "text",
	success: handleSeekOntology
	});
}

function handleSeekOntology (request) {
    //alert('Handler declenche');
    //alert(request);
        
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
    $("#visuLogy").html("<h1>Overview of the workflow suggested for your request</h1><u>The services composing this workflow are:</u>");
    var x=xmlDoc.getElementsByTagName("service");
    if (x.length > 0) {
        for (i=0;i<x.length;i++)
	{
            nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
            $("#visuLogy").append("<br/><b>"+nom+"</b> for output: ");
            output = x[i].getElementsByTagName("output");
            if (output.length > 0) {
                for (j=0;j<output.length;j++)
                {
                    $("#visuLogy").append(x[i].getElementsByTagName("output")[j].childNodes[0].nodeValue+" ");
                }
            }
            $("#visuLogy").append("<br/> and input: ");
	    input = x[i].getElementsByTagName("input");
            if (input.length > 0) {
                for (j=0;j<input.length;j++)
                {
                    $("#visuLogy").append(x[i].getElementsByTagName("input")[j].childNodes[0].nodeValue+" ");
                }
            }
	}
    }
    tableau_urls = []
    $("#visuLogy").append("<div id='genericflow'></div>");
    general_csv = xmlDoc.getElementsByTagName("csvschemafile")[0].childNodes[0].nodeValue;
    displayGraph("https://callisto.calmip.univ-toulouse.fr/callisto/"+general_csv,"genericflow");
    var isoneok = 0;
    if (x.length > 0) {
	svcs_soft = new Array(x.length);
	svcs_inp = new Array(x.length);
	svcs_outp = new Array(x.length);
	for (i=0;i<x.length;i++)
	{
	    nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
	    output = x[i].getElementsByTagName("output");
            if (output.length > 0) {
                outp = [];
                for (j=0;j<output.length;j++)
                {
                    outp[j] = x[i].getElementsByTagName("output")[j].childNodes[0].nodeValue;
            	}
            }
	    input = x[i].getElementsByTagName("input");
	    if (input.length > 0) {
		inp = [];
		for (j=0;j<input.length;j++)
		{
		    inp[j] = x[i].getElementsByTagName("input")[j].childNodes[0].nodeValue;
		}
	    }
            
	    justification = x[i].getElementsByTagName("justification");
	    if (justification.length > 0) {
                justif = [];
		for (j=0;j<justification.length;j++)
                {
                    justif[j] = x[i].getElementsByTagName("justification")[j].childNodes[0].nodeValue.replace(/\./g, ".<br/>");
		}
            }
	    url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
	    tableau_urls[i] = url;
	    csv_file = x[i].getElementsByTagName("csvfile")[0].childNodes[0].nodeValue;
	    //alert("https://callisto.calmip.univ-toulouse.fr/callisto/"+csv_file);
	    svcs_soft[i] = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
	    svcs_inp[i] = inp;
	    svcs_outp[i] = outp;
	    
	    $("#visuLogy").append("<br/><br/><h2>Details for service: "+nom+"</h2><div id='"+nom+"'></div>");
	    displayGraph("https://callisto.calmip.univ-toulouse.fr/callisto/"+csv_file,nom);
	    
	    for (j=0;j<justif.length;j++) {
		$("#visuLogy").append(justif[j]);
	    }
	    $("#visuLogy").append("<b>More information can be found at: <a href='" + url+ "' target='_blank'>"+url+"</a></b><br>");
	    if (svcs_soft[i] != "NoSoft") {
		for (j=0;j<inp.length;j++)
                {
		    isoneok = 1;
                    $("#visuLogy").append("<div id=div_"+inp[j]+">Can you provide information for "+inp[j]+"? <input type = 'text' id='inp_"+inp[j]+"'/></div><br/>");
		    /*alert("in"+inp[j]);
		    for (k=0;k<outp.length;k++) {
			alert("out"+outp[k]);
			if (outp[k]==inp[j]) {
			    //This input may be automated: it is an output given by another service
			    $("#visuLogy").append("Leave this blank for automation<br/>");
			}
		    }*/
                }
	    } else {
		
		$("#visuLogy").append("<b>Automation for this service is unavailable in CALLISTO current version.</b>");
	    }
	}
    }
    for (j=0;j<svcs_inp.length;j++){
	for (l=0;l<svcs_inp[j].length;l++){
	    for (k=0;k<svcs_outp.length;k++) {
		for (m=0;m<svcs_outp[k].length;m++) {
		    //alert(svcs_inp[j][l]+" vs. "+ svcs_outp[k][m]);
		    if (svcs_outp[k][m]==svcs_inp[j][l]) { 
			//This input may be automated: it is an output given by another service                                                                                               
			$("#div_"+svcs_inp[j][l]).append("  Leave this to AUTO for automation (so that the value comes from another service in the workflow)");
			$("#inp_"+svcs_inp[j][l]).val("AUTO");
		    } 
		}
	    }
	}
    }	
    
    if (isoneok == 1) {
	
	$("#visuLogy").append("<input type='button' onclick='AutomateServices();' value='Query suggested services'>");
    }
    file = xmlDoc.getElementsByTagName("schemafile")[0].childNodes[0].nodeValue;
    
    alert("Your request has been processed. Result and explanation are available.");
}
function generateSchema() {
    /*
      generating schema.org description for the dataset
    */
   
    chaine_args = '';
    chaine_args = chaine_args + 'author='+ $("#DatasetAuthor").val() + '&';
    chaine_args = chaine_args + 'name='+ $("#DatasetName").val() + '&';
    chaine_args = chaine_args + 'overview='+ $("#DatasetOverview").val() + '&';
    chaine_args = chaine_args + 'dataset_url='+ $("#DatasetURL").val() + '&';
    chaine_args = chaine_args + 'url='+ $("#ContentURL").val() + '&';
    chaine_args = chaine_args + 'encoding='+ $("#DatasetEncoding").val() + '&';
    chaine_args = chaine_args + 'encoding2='+ $("#DatasetEncoding2").val() + '&';
    chaine_args = chaine_args + 'url2='+ $("#ContentURL2").val() + '&';
    chaine_args = chaine_args + 'variables='+ $("#DatasetMeasures").val() + '&';

    
    //alert(chaine_args);

	var remote=$.ajax({
		url: "/cgi-bin/generate_schema.py",
		method: 'POST',
		data:chaine_args,
		dataType: "text",
		success: handleSchema
	});

}

function handleSchema (request) {

	//alert("handleSchema:"+request);
	if (window.DOMParser)
	{
		//alert('Pas Microsoft');
		parser=new DOMParser();
		xmlDoc=parser.parseFromString(request,"text/xml");
		//alert(xmlDoc);
	}else{ // Internet Explorer
		//alert('Microsoft IE');
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async="false";
		xmlDoc.loadXML(data);
	}
    schemafile = xmlDoc.getElementsByTagName("schemafile")[0].childNodes[0].nodeValue;
    http_request = new XMLHttpRequest();
    http_request.onreadystatechange = handleCheckboxRequest;
    //alert("ouvre:https://callisto.calmip.univ-toulouse.fr/callisto/"+schemafile);
    http_request.open('GET',"https://callisto.calmip.univ-toulouse.fr/callisto/"+schemafile,true);
    http_request.send(null);   
}
function handleCheckboxRequest()
{
    //alert("handle request");
    //alert("affiche");
    document.getElementById('ShowSchema').innerHTML = http_request.responseText;
}
function saveOngoing() {
    submitDataset();
    generateSchema();
}
function submitDataset() {
	/*
	 Registering the dataset inside the database
	 */

    document.getElementById("Wait").style.display="block";
    if ($("#DatasetName").val() == "") {
	alert("A name is mandatory for saving a dataset description. Please provide one.");
	return
    }
    chaine_args = '';
    chaine_args = chaine_args + 'author='+ $("#DatasetAuthor").val() + '&';
    chaine_args = chaine_args + 'name='+ $("#DatasetName").val() + '&';
    chaine_args = chaine_args + 'overview='+ $("#DatasetOverview").val() + '&';
    chaine_args = chaine_args + 'url='+ $("#ContentURL").val() + '&';
    chaine_args = chaine_args + 'encoding='+ $("#DatasetEncoding").val() + '&';
    chaine_args = chaine_args + 'encoding2='+ $("#DatasetEncoding2").val() + '&';
    chaine_args = chaine_args + 'url2='+ $("#ContentURL2").val() + '&';
    chaine_args = chaine_args + 'variables='+ $("#DatasetMeasures").val() + '&';
    
    //alert(chaine_args);

	var remote=$.ajax({
		url: "/cgi-bin/submit_dataset.py",
		method: 'POST',
		data:chaine_args,
		dataType: "text",
		success: handleSubmit
	});

}
function handleSubmit(request) {
    document.getElementById("Wait").style.display="none";
}
function handleSaving (request) {

	//alert(request);
	if (window.DOMParser)
	{
		//alert('Pas Microsoft');
		parser=new DOMParser();
		xmlDoc=parser.parseFromString(request,"text/xml");
		//alert(xmlDoc);
	}else{ // Internet Explorer
		//alert('Microsoft IE');
		xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async="false";
		xmlDoc.loadXML(data);
	}
	document.getElementById("Wait").style.display="none";
}

function AutomateServices() {
    /*
      Gere les appels aux services. 
      Recupere les parametres et fait les envois.
      Tous les resultats sont geres de la meme facon: affichage en html et c'est tout.
      */
    //for (j=0;j<svcs_soft.length;j++)
    for (j=(svcs_soft.length)-1;j>=0;j--)
    {
        alert(svcs_soft[j]);
	chaine_args = '';
	current_outputs = [];
	for (k=0;k<svcs_outp[j].length;k++)
        {
            current_outputs[k] = svcs_outp[j][k];
        }

	for (k=0;k<svcs_inp[j].length;k++)
	{
	    //alert(svcs_inp[j][k]);
	    chaine_args = chaine_args + svcs_inp[j][k] +'='+ $("#inp_"+svcs_inp[j][k]).val() + '&';
	}
	
	chaine_args = chaine_args + "url="+ tableau_urls[j] + '&';
	var outputs = ""
	for (k=0;k<svcs_outp[j].length;k++)
        {
	    if (k== (svcs_outp[j].length -1)) {
		outputs += svcs_outp[j][k] 
	    } 
	    else {
		outputs += svcs_outp[j][k]+","
	    }
            //alert(svcs_inp[j][k]);                                                                                            
        }
	chaine_args = chaine_args + "outputs="+outputs;
	//alert(chaine_args);
	alert("Calling service.. You will be informed when results are available");
	var remote=$.ajax({
	    url: '/cgi-bin/'+svcs_soft[j],
	    method: 'POST',
	    data:chaine_args,
	    async: false,
	    dataType: "text",
	    success: handleServicesAutomation
	});     
	
	/*
	for (k=0;k<svcs_outp[j].length;k++)
        {
            alert(svcs_outp[j][k]);
        }*/
    }
}

function handleServicesAutomation (request) {
    
    //alert('Handler declenche');
    //alert(request);
    
    if (window.DOMParser)
    {
        parser=new DOMParser();
        xmlDoc=parser.parseFromString(request,"text/xml");
	
    }else{ // Internet Explorer                                                                                              
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(request);
    }
    
    var x=xmlDoc.getElementsByTagName("options");
    //alert("options value: "+x[0].childNodes[0].nodeValue);
    for (k=0;k<current_outputs.length;k++)
    {
	//alert("ouput en test: "+current_outputs[k]);
        try{
	    for (nb=0;nb<x[0].getElementsByTagName(current_outputs[k]).length;nb++)
		{
		    var result = x[0].getElementsByTagName(current_outputs[k])[nb].childNodes[0].nodeValue; 
		    //var result = x[0].getElementsByTagName(current_outputs[k])[0].childNodes[0].nodeValue;
		    //alert("result: "+result);
		    if ($("#inp_"+current_outputs[k]).val() == "AUTO") {
			alert("Automated field result is:"+result+" for "+current_outputs[k])
			$("#inp_"+current_outputs[k]).val(result);
			if (result.includes("http")) {
			    $("#ResultsFromServices").append("<br/><a href='"+result+"' target='_blank'>"+result+"</a>");
			} else {
			    $("#ResultsFromServices").append("<br/>"+current_outputs[k]+": "+result);
			}
		    } else {
			alert("Final result (or result for a non automated field) is:"+result+" for "+current_outputs[k])
			if (result.includes("http")) {
                            $("#ResultsFromServices").append("<br/><a href='"+result+"' target='_blank'>"+result+"</a>");
                        } else {
                            $("#ResultsFromServices").append("<br/>"+current_outputs[k]+": "+result);
                        }
		    }
		}
	}
	catch (error) 
	{
	    console.error(error);
	    continue;
	}
    }
    
    //alert("Fin de handler retour service");
    //$("#ResultsFromServices").html(request);
    alert("Results are available, and displayed under the ontology visualization window");
}
function submitToCalmip() {
}

function query_repository() {
    //
    var query = $("#QueryThis").val();
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    var case1 = $("input[type='radio'][name='case1']:checked").val();
    chaine_args = '';
    chaine_args = chaine_args + 'repo='+ repo + '&';
    chaine_args = chaine_args + 'case='+ case1 + '&';
    chaine_args = chaine_args + 'query='+ query + '&';
    
    var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
function handleQueryArcadie (request) {
    //                                                                                                                                                                                                       
    if (window.DOMParser)
    {
        parser=new DOMParser();
        xmlDoc=parser.parseFromString(request,"text/xml");

    }else{ // Internet Explorer                                                                                                                                                                                                        
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(request);
    }
    var case_returned = xmlDoc.getElementsByTagName("case")[0].childNodes[0].nodeValue;
    //alert(case_returned);
    var x=xmlDoc.getElementsByTagName("service");
    if (case_returned == "generic") {
	$("#visuQuery").html("<h2>According to ARCADIE, we know that:</h2>");
	if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
		nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
		statement = x[i].getElementsByTagName("statement")[0].childNodes[0].nodeValue;
		claim = x[i].getElementsByTagName("claim")[0].childNodes[0].nodeValue;
		$("#visuQuery").append("<div id=\""+nom+"\">"+statement);
		$("#visuQuery").append("<input type=\"button\"  onclick=\"aboutClaim("+claim+");\" id=\"repo_query\" value=\"More about this claim\"/>");
		$("#visuQuery").append("<input type=\"button\"  onclick=\"getDataClaim("+claim+");\" id=\"repo_query\" value=\"Get data sustaining this claim\"/></div>");
            }
	}
    }
    if (case_returned == "about") {
	$("#visuQuery").append("<div id=\"about\"></div>");
	$("#about").html("");
        if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
                citation = x[i].getElementsByTagName("citation")[0].childNodes[0].nodeValue;
                publisher = x[i].getElementsByTagName("publisher")[0].childNodes[0].nodeValue;
                $("#about").append("<br/>This claim comes from the reference: "+citation+"<br/>");
		$("#about").append("<br/>Published by: "+publisher+"<br/>");
            }
        }
    }
    if (case_returned == "dataClaim") {
        $("#visuQuery").append("<div id=\"about\"></div>");
        $("#about").html("");
        if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
                url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
                $("#about").append("<br/>Data is downloadable at: <a href=\""+url+"\">"+url+"</a><br/>");
            }
        }
    }
    if (case_returned == "data") {
        $("#visuQuery").html("<h2>Here is a list of services that may be useful:</h2>");
        if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
                nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
		soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
		url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue; 
		description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue; 
		$("#visuQuery").append(nom+": <br/>"+description+"<br/><input type=\"button\"  onclick=\"getDetails(['"+nom+"']);\" value=\"Get details\"/>");
		if (soft == "get_dataset") {
		    $("#visuQuery").append("<br/>Data direct download: <a href='"+url+"'>Click HERE</a>")
		}
            }
        }
    }
    if (case_returned == "getDetails") {
	//alert("handling getDetails:"+x.length);
	$("#visuQuery").append("<div id=\"about\"></div>");
        $("#about").html("");
        if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
		//alert(i);
                statement = x[i].getElementsByTagName("statement")[0].childNodes[0].nodeValue;
		publisher = x[i].getElementsByTagName("publisher")[0].childNodes[0].nodeValue;
		description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;
		datadesc = x[i].getElementsByTagName("datadesc")[0].childNodes[0].nodeValue;
		//alert("<b>Description of the service:</b><br/>"+description+"<br/>");
                $("#about").append("<b>Description of the service:</b><br/>"+description+"<br/>");
                $("#about").append("<b>Service published by (when available):</b><br/>"+publisher+"<br/>");
		$("#about").append("<b>Data coming from this service argues that (when applicable):</b><br/>"+statement+"<br/>");
		$("#about").append("<b>Fine-grained description of the data (when available):</b><br/>"+datadesc+"<br/>");
            }
        }
    }

    if (case_returned == "functionality") {
        //alert("handling getDetails:"+x.length);                                                                                                                                
        $("#visuQuery").append("<div id=\"about\"></div>");
        $("#about").html("");
        if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
                //alert(i);                                                                                                                                                      
                nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
                
                $("#about").append("<b>The following functionality is available:</b><br/>"+nom+"<br/>");
                
            }
        }
    }

}

function getDetails(service) {
    //alert("into getDetails");
    chaine_args = 'case=getDetails&';
    chaine_args = chaine_args + 'service='+ service + '&';
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
function getData(service) {
    chaine_args = 'case=getData&';
    chaine_args = chaine_args + 'service='+ service + '&';
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}

function aboutClaim(claim) {
    //
    chaine_args = 'case=about&';
    chaine_args = chaine_args + 'claim='+ claim + '&';
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
function getDataClaim(claim) {
    //                                                                                                                                                                                                     
    chaine_args = 'case=dataClaim&';
    chaine_args = chaine_args + 'claim='+ claim + '&';
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}


function displayGraph(graphfile,element){
    // get the data
    d3.csv(graphfile, function(error, links) {
	var nodes = {};
	
	// Compute the distinct nodes from the links.
	links.forEach(function(link) {
	    link.source = nodes[link.source] || 
		(nodes[link.source] = {name: link.source});
	    link.target = nodes[link.target] || 
		(nodes[link.target] = {name: link.target});
	    link.value = +link.value;
	});
	
	var width = 800,
	height = 200;
	
	var force = d3.layout.force()
	    .nodes(d3.values(nodes))
	    .links(links)
	    .size([width, height])
	    .linkDistance(60)
	    .charge(-300)
	    .on("tick", tick)
	    .start();
	
	var svg = d3.select("#"+element).append("svg")
	    .attr("width", width)
	    .attr("height", height);
	
	// build the arrow.
	svg.append("svg:defs").selectAll("marker")
	    .data(["end"])
	    .enter().append("svg:marker")
	    .attr("id", String)
	    .attr("viewBox", "0 -5 10 10")
	    .attr("refX", 15)
	    .attr("refY", -1.5)
	    .attr("markerWidth", 6)
	    .attr("markerHeight", 6)
	    .attr("orient", "auto")
	    .append("svg:path")
	    .attr("d", "M0,-5L10,0L0,5");
	
	// add the links and the arrows
	var path = svg.append("svg:g").selectAll("path")
	    .data(force.links())
	    .enter().append("svg:path")
	    .attr("class", "link")
	    .attr("marker-end", "url(#end)");
	
	// define the nodes
	var node = svg.selectAll(".node")
	    .data(force.nodes())
	    .enter().append("g")
	    .attr("class", "node")
	    .call(force.drag);
	
	// add the nodes
	node.append("circle")
	    .attr("r", function(d) {
		if (d.name.includes("service:")) {
		    //alert(d.name);                                                                                                                                                                              
		    return 10;}
                else {
                    return 5;
                };
	    });
	node.style("fill", function (d) {
            if (d.name.includes("service:")) {
                //alert(d.name);                                                                                                                                                                                  
                return '#00bfff';
	    }
	});
	node.style("font-size", function(d) {
            if (d.name.includes("service:")) {
                //alert(d.name);                                                                                                                                                                                 
                return "15px";
            }
            else {
                return "10px";
            };
        });
	
	// add the text 
	node.append("text")
	    .attr("x",12)
	    .attr("dy", ".35em")
	    .text(function(d) { return d.name; });
	
	function tick() {
	    path.attr("d", function(d) {
		var dx = d.target.x - d.source.x,
		dy = d.target.y - d.source.y;
		return "M" + 
		    d.source.x + "," + 
		    d.source.y + "L" + 
		    d.target.x + "," + 
		    d.target.y;
	    });
	    
	    node
		.attr("transform", function(d) { 
		    return "translate(" + d.x + "," + d.y + ")"; });
	    node
		.attr("r",function(d){
		    if (d.name.includes("service:")) {
			//alert(d.name);
			return 100;} 
		    else {
			return 5;
		    };
		});
	}
	
    });
}

function SeekInformation() {
    var query = $("#Information").val();
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    var case1 = "data";
    chaine_args = '';
    chaine_args = chaine_args + 'repo='+ repo + '&';
    chaine_args = chaine_args + 'case='+ case1 + '&';
    chaine_args = chaine_args + 'query='+ query + '&';
    
    var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
    
}

function handleSeekInformation(request)  {
    if (window.DOMParser)
    {
        parser=new DOMParser();
        xmlDoc=parser.parseFromString(request,"text/xml");

    }else{ // Internet Explorer                                                                                                                                                                                                        
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(request);
    }
    var x=xmlDoc.getElementsByTagName("service");
    $("#available_data").html("")
    if (x.length > 0) {
	$("#available_data").append("<table id='data_semi_auto' cellpadding = '5' cellspacing = '5'><thead><tr><th>nom</th><th>soft</th><th>url</th><th>Select</th></tr></thead>")
        for (i=0;i<x.length;i++)
        {
	    nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
	    soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
	    url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue; 
	    $("#data_semi_auto").append("<tr><td>"+nom+"</td><td>"+soft+"</td><td>"+url+"</td><td><input type='radio' name = 'data_selected' id='r'"+i+" value="+i+"></td></tr>")
	}
	$("#davailable_data").append("</table>")
	$("#available_data").append("<br/>STEP2: See what operations are available on the selected dataset, whith which software.")
	$("#available_data").append("<input type='button'  onclick='SeekOperations();' id='seek_software' value='Seek operations'/>")
    }
    
}


function SeekOperations() {
    var query = $("#Information").val();
    var dataset = $("input[type='radio'][name='data_selected']:checked").val();
    var case1 = "data";
    chaine_args = '';
    chaine_args = chaine_args + 'repo='+ repo + '&';
    chaine_args = chaine_args + 'case='+ case1 + '&';
    chaine_args = chaine_args + 'query='+ query + '&';
    
    /*var remote=$.ajax({
        url: "/cgi-bin/ARCADIE_SPARQL.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });*/
    alert(dataset);
    
}

function Register_data_service() {
    
    var description = $("#Description").val();
    var measurement = $("#measurement").val();
    var format = $("#format").val();
    var unit = $("#unit").val();
    var url = $("#url").val();
    var keywords = $("#keywords").val();
    
    chaine_args = 'type=data&';
    chaine_args = chaine_args + 'description='+ description + '&';
    chaine_args = chaine_args + 'measurement='+ measurement + '&';
    chaine_args = chaine_args + 'format='+ format + '&';
    chaine_args = chaine_args + 'unit='+ unit + '&';
    chaine_args = chaine_args + 'url='+ url + '&';
    chaine_args = chaine_args + 'keywords='+keywords+'&';
    chaine_args = chaine_args + 'repo='+aff_repo.repository;
    
    var remote=$.ajax({
        url: "/cgi-bin/Register_service.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
}

function Register_software_service() {
    
    var description = $("#Profile_soft").val();
    var input_soft = $("#input_soft").val();
    var format_in_soft = $("#format_in_soft").val();
    var unit_in_soft = $("#unit_in_soft").val();
    var keywords = $("#keywords").val();
    
    chaine_args = 'type=software&';
    chaine_args = chaine_args + 'description='+ description + '&';
    chaine_args = chaine_args + 'measurement='+ measurement + '&';
    chaine_args = chaine_args + 'format='+ format + '&';
    chaine_args = chaine_args + 'unit='+ unit + '&';
    chaine_args = chaine_args + 'keywords='+keywords+'&';
    chaine_args = chaine_args + 'repo='+aff_repo.repository;
    
    var remote=$.ajax({
        url: "/cgi-bin/Register_service.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
}
