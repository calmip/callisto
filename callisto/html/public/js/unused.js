//unused
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

//unused
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
    //alert("ouvre:https://www.callisto.calmip.univ-toulouse.fr/www.callisto/"+schemafile);
    http_request.open('GET',"https://allegro.callisto.calmip.univ-toulouse.fr/www.callisto/TempFiles"+schemafile,true);
    http_request.send(null);   
}

//unused
function handleCheckboxRequest()
{
    //alert("handle request");
    //alert("affiche");
    document.getElementById('ShowSchema').innerHTML = http_request.responseText;
}

// unused
function saveOngoing() {
    submitDataset();
    generateSchema();
}

// unused
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

// unused
function handleSubmit(request) {
    document.getElementById("Wait").style.display="none";
}

// unused
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

// unused 
function getDetails(service) {
    //alert("into getDetails");
    chaine_args = 'case=getDetails&';
    chaine_args = chaine_args + 'service='+ service + '&';
    
    var repo = active_repo;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
// unused 
function getData(service) {
    chaine_args = 'case=getData&';
    chaine_args = chaine_args + 'service='+ service + '&';
    
    var repo = active_repo;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
// unused 
function aboutClaim(claim) {
    //
    chaine_args = 'case=about&';
    chaine_args = chaine_args + 'claim='+ claim + '&';
    
    var repo = active_repo;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}
// unused 
function getDataClaim() {
    //                                                                                                                                                                                                     
    chaine_args = 'case=dataClaim&';
    chaine_args = chaine_args + 'claim='+ claim + '&';
    
    
    var repo = active_repo;
    chaine_args = chaine_args + 'repo='+ repo + '&';
    var remote=$.ajax({
        url: "/cgi-bin/Allegro_Fcts.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleQueryArcadie
    });
}

// unused
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
    chaine_args = chaine_args + 'repo='+active_repo;
    
    var remote=$.ajax({
        url: "/cgi-bin/Register_service.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
}

// unused
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
    chaine_args = chaine_args + 'repo='+active_repo;
    
    var remote=$.ajax({
        url: "/cgi-bin/Register_service.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
}

// unused
function generateLink(url) {
    alert(url);
    ivalue = url.split(",")[1];
    alert(ivalue);
    var key = $("#inp_"+ivalue-1).val();
    alert(key);
    alert("<a href="+url.replace("\"","")+key+">DOWNLOAD</a>");
    window.open("https://"+url.replace("\"","")+key);
}

// unused
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
    chaine_args = chaine_args + 'repo='+active_repo;
    
    var remote=$.ajax({
        url: "/cgi-bin/Register_service.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
}

//unused
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
    chaine_args = chaine_args + 'repo='+active_repo;
    
    var remote=$.ajax({
        url: "/cgi-bin/Register_service.py",
        method: 'POST',
        data:chaine_args,
        dataType: "text",
        success: handleSeekInformation
    });
}

//unused
function generateLink(url) {
    alert(url);
    ivalue = url.split(",")[1];
    alert(ivalue);
    var key = $("#inp_"+ivalue-1).val();
    alert(key);
    alert("<a href="+url.replace("\"","")+key+">DOWNLOAD</a>");
    window.open("https://"+url.replace("\"","")+key);
}
