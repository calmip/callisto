function Change_repository() {
    aff_repo.repository = $("input[type='radio'][name='repo1']:checked").val();
}

function SeekOntology() {
    
    var repo = aff_repo.repository;
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


function handleOperationsWorkflow (request) {
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
    $("#available_wflows").html("");

    var x=xmlDoc.getElementsByTagName("service");
    if (x.length > 0) {
        for (i=0;i<x.length;i++)
	{
            nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
	    ontology_id = x[i].getElementsByTagName("ontology_id")[0].childNodes[0].nodeValue;
            
	    $("#available_wflows").append("<br/><a href=\"https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/#/repositories/"+aff_repo.repository+"/node/<http://www.{{callisto_name}}.{{callisto_topdomainname}}/"+aff_repo.repository.toUpperCase()+".rdf%23"+ontology_id.split("#")[1]+">\" target=\"_blank\"><b><u>"+nom+"</u></b></a> for <b>OUTPUT</b>: ");
            output = x[i].getElementsByTagName("output_definition");
	    
            if (output.length > 0) {
                for (j=0;j<output.length;j++)
                {
		$("#available_wflows").append("<a href=\"https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/#/repositories/"+aff_repo.repository+"/node/<http://www.{{callisto_name}}.{{callisto_topdomainname}}/"+aff_repo.repository.toUpperCase()+".rdf%23"+x[i].getElementsByTagName("output")[j].childNodes[0].nodeValue+">\" target=\"_blank\"><b><u>"+x[i].getElementsByTagName("output")[j].childNodes[0].nodeValue+"</u></b></a>");	
                }
            }
            $("#available_wflows").append(" with <b>INPUT</b>: ");
	    input = x[i].getElementsByTagName("input_definition");
            if (input.length > 0) {
                for (j=0;j<input.length;j++)
                {
                    $("#available_wflows").append("<a href=\"https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/#/repositories/"+aff_repo.repository+"/node/<http://www.{{callisto_name}}.{{callisto_topdomainname}}/"+aff_repo.repository.toUpperCase()+".rdf%23"+x[i].getElementsByTagName("input")[j].childNodes[0].nodeValue+">\" target=\"_blank\"><b><u>"+x[i].getElementsByTagName("input_definition")[j].childNodes[0].nodeValue+"</u></b></a>");
                }
            }
	    $("#available_wflows").append("<br/> <b>Description of the service:<b> ");
	    //profdef = x[i].getElementsByTagName("profdef");
            $("#available_wflows").append(x[i].getElementsByTagName("profdef")[0].childNodes[0].nodeValue+" ");
	    $("#available_wflows").append("<br/><br/>");
                
	}
    }
    tableau_urls = []
    $("#available_wflows").append("<div id='genericflow'></div>");
    general_csv = xmlDoc.getElementsByTagName("csvschemafile")[0].childNodes[0].nodeValue;
    displayGraph("https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}"+general_csv,"genericflow");
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
            
	    url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
	    tableau_urls[i] = url;
	    
	    svcs_soft[i] = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue.replace("\"","");
	    svcs_inp[i] = inp;
	    svcs_outp[i] = outp;
	    
	    
	    if (svcs_soft[i] != "NoSoft") {
		for (j=0;j<inp.length;j++)
                {
		    isoneok = 1;
		    //if (inp[j]!="No input required") {
		    if (inp[j]=="ApiKeyValue") {
			$("#available_wflows").append("<div id=div_"+inp[j]+">A value is required for <a href=\"https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/#/repositories/"+aff_repo.repository+"/node/<http://www.{{callisto_name}}.{{callisto_topdomainname}}/"+aff_repo.repository.toUpperCase()+".rdf%23"+inp[j]+">\" target=\"_blank\">"+inp[j]+"</a> <input type = 'text' id='inp_"+inp[j]+"'/></div><br/>");
			}
		    else if (inp[j]!="No input required")
		    {
			$("#available_wflows").append("<div style=\"display:none\" id=div_"+inp[j]+"><input visibility=\"hidden\" type = 'text' id='inp_"+inp[j]+"'/></div>");
		    }
		    /*alert("in"+inp[j]);*/
		    for (k=0;k<outp.length;k++) {
			//alert("out"+outp[k]);
			if (outp[k]==inp[j]) {
			    //This input may be automated: it is an output given by another service
			    $("#available_wflows").append("Leave this blank for automation<br/>");
			}
		    }
                }
	    } 

	}
    }
    equivalents = [];
    match = 0;
    for (j=0;j<svcs_inp.length;j++){
	for (l=0;l<svcs_inp[j].length;l++){
	    for (k=0;k<svcs_outp.length;k++) {
		for (m=0;m<svcs_outp[k].length;m++) {
		    //alert(svcs_inp[j][l]+" vs. "+ svcs_outp[k][m]);
		    if (svcs_outp[k][m]==svcs_inp[j][l]) { 
			//This input may be automated: it is an output given by another service                                                                                               
			//$("#div_"+svcs_inp[j][l]).append("  Leave this to AUTO for automation (so that the value comes from another service in the workflow)");
			$("#inp_"+svcs_inp[j][l]).val("AUTO");
		    } 
		}
	    }
	
	    for (k=0;k<svcs_inp.length;k++) {
		for (m=0;m<svcs_inp[k].length;m++) {
		    //alert(svcs_inp[j][l]+" vs. "+ svcs_outp[k][m]);
		    if (svcs_inp[k][m]==svcs_inp[j][l]) { 
			//This input may be automated: it is an output given by another service                                                                                               
			//$("#div_"+svcs_inp[j][l]).append("  Leave this to AUTO for automation (so that the value comes from another service in the workflow)");
			if(j!=k) {
			    //alert("Found matching inputs between:"+svcs_names[j]+" and" +svcs_names[k]);
			    for (sortie1=0;sortie1<svcs_outp[j].length;sortie1++) {
				//alert("output from:"+svcs_names[j]+" is: "+svcs_outp[j][sortie1]);
				for (sortie2=0;sortie2<svcs_outp.length;sortie2++) {
				    if (j==sortie2) {continue} else{
					for (sortie3=0;sortie3<svcs_outp[sortie2].length;sortie3++) {
					    //alert("output from:"+svcs_names[sortie2]+" is "+svcs_outp[sortie2][sortie3]);
					    if (svcs_outp[sortie2][sortie3] == svcs_outp[j][sortie1]) {
						//alert(svcs_names[sortie2]+ " et "+ svcs_names[j]+" sont équivalents");
						if (match == 0) {
						    $("#available_wflows").append("Some choice is to be made: which service would you use? ")
						    match = 1;
						}
						if(!equivalents.includes(j)) {
						    equivalents.push(j);
						    $("#available_wflows").append("<input type=\"radio\" checked=\"checked\" name=\"wflow_choice\" id=\"wflow_choice\" value=\""+j+"\">S"+j);
						}
						if(!equivalents.includes(sortie2)) {
						    equivalents.push(sortie2);
						    $("#available_wflows").append("<input type=\"radio\" checked=\"checked\" name=\"wflow_choice\" id=\"wflow_choice\" value=\""+sortie2+"\">S"+sortie2);
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
	$("#available_wflows").append("<br/><input type='button' onclick='AutomateServices();' value='Query services'>");
    }
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
    http_request.open('GET',"https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/callisto/"+schemafile,true);
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
      Tous les resultats sont geres de la meme facon: affichage en html.
      */
    //alert(svcs_soft.length+"services to call");
    //alert($("#wflow_choice:checked").val());
    /*
      const list = [0,3]
    list.forEach((item, index) => {
	console.log(item) //value
	console.log(index) //index
    //})
    */

    for (s_to_call=0;s_to_call<=(svcs_soft.length)-1;s_to_call++)
    {
	/*alert("call number:");
	alert(s_to_call);
        alert(svcs_soft[s_to_call]);*/
	if(!equivalents.includes(s_to_call) || (s_to_call == $("#wflow_choice:checked").val())) {
	    //alert(svcs_soft[s_to_call]);
	    alert("Calling service "+svcs_names[s_to_call]+"... This may take a few minutes");
	    chaine_args = '';
	    current_outputs = [];
	    for (k=0;k<svcs_outp[s_to_call].length;k++)
            {
		current_outputs[k] = svcs_outp[s_to_call][k];
            }
	    
	    for (k=0;k<svcs_inp[s_to_call].length;k++)
	    {
		//alert(svcs_inp[s_to_call][k]);
		chaine_args = chaine_args + svcs_inp[s_to_call][k] +'='+ $("#inp_"+svcs_inp[s_to_call][k]).val() + '&';
	    }
	    
	    chaine_args = chaine_args + "url="+ tableau_urls[s_to_call] + '&';
	    var outputs = ""
	    for (k=0;k<svcs_outp[s_to_call].length;k++)
            {
		if (k== (svcs_outp[s_to_call].length -1)) {
		    outputs += svcs_outp[s_to_call][k] 
		} 
		else {
		    outputs += svcs_outp[s_to_call][k]+","
		}                                                                                        
            }
	    chaine_args = chaine_args + "outputs="+outputs;
	    //alert(chaine_args);
	    //alert("Calling service.. You will be informed when results are available");
	    var remote=$.ajax({
		url: '/cgi-bin/'+svcs_soft[s_to_call].replace("\"",""),
		method: 'POST',
		data:chaine_args,
		async: false,
		dataType: "text",
		success: handleServicesAutomation
	    });     
	    //alert("after request");
	    //alert(s_to_call);
	}
    }

}

function handleServicesAutomation (request) {
    
    /*alert('Handler declenche');
    alert(request);*/
    
    if (window.DOMParser)
    {
        parser=new DOMParser();
        xmlDoc=parser.parseFromString(request,"text/xml");
	
    }else{ // Internet Explorer                                                                                              
        xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
        xmlDoc.async="false";
        xmlDoc.loadXML(request);
    }
    //alert(xmlDoc.getElementsByTagName("C_p")[0].childNodes[0].nodeValue);
    var x=xmlDoc.getElementsByTagName("options");
    //alert("options value: "+x[0].childNodes[0].nodeValue);
    for (k=0;k<current_outputs.length;k++)
    {
	/*alert("ouput en test:"+current_outputs[k]);
	alert(x[0].getElementsByTagName(current_outputs[k]).length);*/
        try{
	    for (nb=0;nb<x[0].getElementsByTagName(current_outputs[k]).length;nb++)
		{
		    var result = x[0].getElementsByTagName(current_outputs[k])[nb].childNodes[0].nodeValue; 
		    //alert("Automated result: "+result);
		    if ($("#inp_"+current_outputs[k]).val() == "AUTO") {
			$("#inp_"+current_outputs[k]).val(result);
			if (result.includes("http")) {
			    $("#available_wflows").append("<br/>"+current_outputs[k]+": <a href='"+result+"' target='_blank'>"+result+"</a>");
			} else {
			    $("#available_wflows").append("<br/>"+current_outputs[k]+": "+result);
			}
		    } else {
			//alert("Final result (or result for a non automated field) is:"+result+" for "+current_outputs[k])
			if (result.includes("http")) {
			    $("#available_wflows").append("<br/><a href=\"../cgi-bin/Display_ontology_element.py?repo="+aff_repo.repository+"&element="+current_outputs[k]+"\" target=\"_blank\">"+current_outputs[k]+"</a>: <a href='"+result+"' target='_blank'>"+result+"</a>");
                        } else {
			    $("#available_wflows").append("<br/><a href=\"../cgi-bin/Display_ontology_element.py?repo="+aff_repo.repository+"&element="+current_outputs[k]+"\" target=\"_blank\">"+current_outputs[k]+"</a>:"+result);
                        }
		    }
		
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
	}
	catch (error) 
	{
	    console.error(error);
	    continue;
	}
    }
}

function query_repository() {
    //
    var query = $("#QueryThis").val();
    //var repo = $("input[type='radio'][name='repo1']:checked").val();
    var repo = aff_repo.repository;
    var case1 = $("input[type='radio'][name='case1']:checked").val();
    if (case1 == "composition") {
	 SeekOntology();
    }
    else {
	chaine_args = '';
	chaine_args = chaine_args + 'repo='+ repo + '&';
	chaine_args = chaine_args + 'case='+ case1 + '&';
	chaine_args = chaine_args + 'query='+ query + '&';
	//alert(chaine_args);
	var remote=$.ajax({
	    url: "/cgi-bin/Allegro_Fcts.py",
	    method: 'POST',
	    data:chaine_args,
	    dataType: "text",
	    success: handleQueryArcadie
	});
    }
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
    //alert(request);
    var case_returned = xmlDoc.getElementsByTagName("case")[0].childNodes[0].nodeValue;
	//$("#visuQuery").html("");    
    //alert(case_returned);
    var x=xmlDoc.getElementsByTagName("service");
    if (case_returned == "generic") {
	$("#visuQuery").html("");
	//$("#visuQuery").html("<h1>According to ARCADIE, we know that:</h1>");
	if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
		statement = x[i].getElementsByTagName("statement")[0].childNodes[0].nodeValue;
		claim = x[i].getElementsByTagName("claim")[0].childNodes[0].nodeValue;
		citation = x[i].getElementsByTagName("citation")[0].childNodes[0].nodeValue;
		url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
		urldata = x[i].getElementsByTagName("urldata")[0].childNodes[0].nodeValue;
		$("#visuQuery").append("<div>"+statement+"<br/><b>As stated in the following paper:</b><br/>");
		$("#visuQuery").append("<div><a href="+url+"target=\"_blank\">"+citation+"</a><br/>");
		if (urldata != "\"No Url attached\"")
		    {
			$("#visuQuery").append("Get data directly sustaining this claim:<a href="+urldata+"target=\"_blank\">"+urldata+"</a><br/>");
		    }
		else
		    {
			$("#visuQuery").append("<b>No download link is available for data directly sustaining this claim</b><br/>");
		    }
		
		$("#visuQuery").append("<br/>This paper is also related to the following concepts:<br/>")
		quals =  x[i].getElementsByTagName("qual");
		for (qu=0;qu<quals.length;qu++)
		    {
			//$("#visuQuery").append("<br/><a href=\"../cgi-bin/Display_ontology_element.py?repo="+aff_repo.repository+"&element="+quals[qu].childNodes[0].nodeValue+"\" target=\"_blank\">"+quals[qu].childNodes[0].nodeValue+"</a>");
			$("#visuQuery").append("<br/><a href=\"https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/#/repositories/"+aff_repo.repository+"/node/<http://www.callisto.calmip.univ-toulouse.fr/"+aff_repo.repository.toUpperCase()+".rdf%23"+quals[qu].childNodes[0].nodeValue+">\" target=\"_blank\">"+quals[qu].childNodes[0].nodeValue+"</a>");			
		    }
		$("#visuQuery").append("<br/><input type='button'  onclick='getDataClaim()'; id='repo_query' value='Get data relevant for this topic'/></div>");
		
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
	var x=xmlDoc.getElementsByTagName("service");
	if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
		nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
		description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;
		soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue;
		url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
		$("#about").append("<br/><b>A relevant dataset may be the following:</b><br/>"+description+"<br/>");
		inputs =  x[i].getElementsByTagName("input");
		$("#about").append("<br/>Please indicate your CALLISTO Dataverse API key to access data:<br/><input type = 'text' id='inp_"+i+"' value='Your API Key here'/><input type=\"button\"  onclick='generateLink(\""+url+"\","+i+");' value='Download'/>");
		
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
	$("#visuQuery").html("");
            $("#visuQuery").append("<div id=\"about\"></div>");
            $("#about").html("");
        if (x.length > 0) {
            for (i=0;i<x.length;i++)
            {
                //alert(i);                                                                                                                                                      
                label = x[i].getElementsByTagName("label")[0].childNodes[0].nodeValue;
                definition = x[i].getElementsByTagName("definition")[0].childNodes[0].nodeValue;
		svc = x[i].getElementsByTagName("svc")[0].childNodes[0].nodeValue;
                $("#about").append("<b>The following functionality is available:</b><br/>"+label+"<br/>");
		$("#about").append("Defined as: <br/>"+definition+"<br/>");
		$("#about").append("<a href='https://{{allegro_subdomain}}.{{callisto_name}}.{{callisto_topdomainname}}/#/repositories/"+aff_repo.repository+"/node/<http://www.callisto.calmip.univ-toulouse.fr/"+aff_repo.repository.toUpperCase()+".rdf%23"+svc+">'>View it on ontology</a><br/>");
		
                
            }
        }   
     }

}

function getDetails(service) {
    //alert("into getDetails");
    chaine_args = 'case=getDetails&';
    chaine_args = chaine_args + 'service='+ service + '&';
    
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
function getData(service) {
    chaine_args = 'case=getData&';
    chaine_args = chaine_args + 'service='+ service + '&';
    
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
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
    
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
function getDataClaim() {
    //                                                                                                                                                                                                     
    chaine_args = 'case=dataClaim&';
    chaine_args = chaine_args + 'claim='+ claim + '&';
    
    
    var repo = aff_repo.repository;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}


function displayGraph(graphfile,element){
    // get the data
    //alert("Graph for: "+graphfile);
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
	
	var width = 1600,
	height = 400;
	
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
                return "15px";
            };
        });
	
	// add the text 
	node.append("text")
	    .attr("x",12)
	    .attr("dy", ".35em")
	    .text(function(d) { return d.name.replace('service:',''); });
	
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
    
    var repo = aff_repo.repository;
    var case1 = "data";
    chaine_args = '';
    chaine_args = chaine_args + 'repo='+ repo + '&';
    chaine_args = chaine_args + 'case='+ case1 + '&';
    chaine_args = chaine_args + 'query='+ query + '&';
    
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
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
    $("#available_data").html("");
    $("#available_wflows").html("");
    if (x.length > 0) {
	
	$("#available_data").append("<table id='data_semi_auto' cellpadding = '5' cellspacing = '5'><thead><tr><th>Service id</th><th>Description</th><th>Select</th></thead>")
        for (i=0;i<x.length;i++)
        {
	    nom = x[i].getElementsByTagName("nom")[0].childNodes[0].nodeValue;
	    try {
		soft = x[i].getElementsByTagName("soft")[0].childNodes[0].nodeValue.replace("\"","");
	    }
	    catch (error){}
	    try {
		url = x[i].getElementsByTagName("url")[0].childNodes[0].nodeValue;
	    }
	    catch (error){}
	    description = x[i].getElementsByTagName("description")[0].childNodes[0].nodeValue;

	    $("#data_semi_auto").append("<tr><td>"+nom.split("#")[1].replace("\"","")+"</td><td>"+description.replace("b\'","").replace("\"","")+"</td> <td><input type='radio' name = 'data_selected' id='r'"+i+" value="+nom+"></td></tr>")
	}
	$("#davailable_data").append("</table>")
	$("#available_data").append("<br/>See what operations are available on the selected dataset, whith which software.")
	$("#available_data").append("<input type='button'  onclick='SeekOperations();' id='seek_software' value='Seek operations'/>")
    }
    
}


function SeekOperations() {
    var repo = aff_repo.repository;
    
    var query = $("#Information").val();
    var dataset = $("input[type='radio'][name='data_selected']:checked").val();
    var case1 = "seek_operations";
    chaine_args = '';
    chaine_args = chaine_args + 'repo='+ repo + '&';
    chaine_args = chaine_args + 'case='+ case1 + '&';
    chaine_args = chaine_args + 'dataset='+ dataset + '&';


    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleOperationsWorkflow
    });
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

function generateLink(url,ivalue) {
    //alert(url);
    var key = $("#inp_"+ivalue).val();
    //alert(key);
    //alert("<a href='"+url+key+"'>DOWNLOAD</a>");
    window.open("https://"+url+key);
}
