var aff_repo = new Vue({
    el: '#affected_repo',
    data: {
    repository: 'demonstration'
    }
})
var operation_choice = new Vue({
    el: '#case',
    data: {
	run_basic_search: false,
	change_repo: false,
	repo_specific: false,
	semi_auto: false,
	workflow: false,
	register_data_service: false,
	register_software_service: false
    }
})
function Choose_operation() {
    operation_choice.run_semantic_search = false;
    operation_choice.repo_specific = false;
    operation_choice.semi_auto = false;
    operation_choice.workflow = false;
    operation_choice.change_repo = false;
    operation_choice.register_data_service = false;
    operation_choice.register_software_service = false;
    operation_choice.biblio = false;
    //Si on change d'operation avant d'avoir validé un 
    //dépôt on force dépôt public
    if (aff_repo.repository == "changing repository...") {
	aff_repo.repository = "public";
    }
    var operation = $("input[type='radio'][name='operation']:checked").val();
    //alert(operation);
    if (operation == "change_repo") {
	operation_choice.change_repo = true;
    }
    if (operation == "semantic_query") {
	//alert("enabling basic query");
	operation_choice.run_semantic_search = true;
	//alert(operation_choice.run_basic_search);
	//alert(operation_choice.repo_specific);
    }
    if (operation == "semi_auto") {
	operation_choice.semi_auto = true;
    }
    if (operation == "workflow") {
	operation_choice.workflow = true;
    }
    if (operation == "register_data_service") {
	operation_choice.register_data_service = true;
    }
    if (operation == "biblio") {
	ClaimNumber = 1;
	operation_choice.biblio = true;
    }
    if (operation == "register_software_service") {
	InputNumber = 1;
	OutputNumber = 1;
	operation_choice.register_software_service = true;
    }
    
};
function Check_password() {
    var repo = $("input[type='radio'][name='repo1']:checked").val();
    if (repo == "public") {
	aff_repo.repository= "public";
	operation_choice.repo_specific = false;
    }
    if (repo == "specific") {
	aff_repo.repository= "changing repository...";
	operation_choice.repo_specific = true;
    }
};
function addClaim(){
    // Container <div> where dynamic content will be placed
    var container = document.getElementById("ClaimContainer");
    // Append a node
    container.appendChild(document.createTextNode("Claim " + (ClaimNumber)));
    // Create an <input> element, set its type and name attributes
    var claim = document.createElement('textarea', {width:400,id:'claim'+ClaimNumber});
    claim.type = "text";
    claim.name = "claim" + ClaimNumber;
    claim.id = "claim" + ClaimNumber;
    container.appendChild(claim);
    // Append a line break 
    container.appendChild(document.createElement("br"));
    ClaimNumber += 1;    
}
function addInput(){
    // Container <div> where dynamic content will be placed
    var container = document.getElementById("InputContainer");
    // Append a node
    container.appendChild(document.createTextNode("Input " + (InputNumber)));
    // Create an <input> element, set its type and name attributes
    var input = document.createElement("input");
    input.type = "text";
    input.name = "member" + InputNumber;
    var inputText = document.createElement("P");
    inputText.innerText = "How would you briefly describe this input (e.g: Ground temperature, air speed.)?";
    container.appendChild(inputText);
    container.appendChild(input);
    var format = document.createElement("input");
    format.type = "text";
    format.name = "format" + InputNumber;
    var formatText = document.createElement("P");
    formatText.innerText = "What is the format of the input? (CSV, FITS, JPEG...)"
    container.appendChild(formatText);
    container.appendChild(format);
    var unit = document.createElement("input");
    unit.type = "text";
    unit.name = "unit" + InputNumber;
    var unitText = document.createElement("P");
    unitText.innerText = "What is the unit for this input? (mag, eV, T, W...)"
    container.appendChild(unitText);
    container.appendChild(unit);
    // Append a line break 
    container.appendChild(document.createElement("br"));
    InputNumber += 1;
    
}
function addOutput(){
    // Container <div> where dynamic content will be placed
    var container = document.getElementById("OutputContainer");
    // Append a node
    container.appendChild(document.createTextNode("Output " + (OutputNumber)));
    // Create an <input> element, set its type and name attributes
    var output = document.createElement("input");
    output.type = "text";
    output.name = "member" + OutputNumber;
    var outputText = document.createElement("P");
    outputText.innerText = "How would you briefly describe this output (e.g: Averaged ground temperature, cumulated air speed.)?";
    container.appendChild(outputText);
    container.appendChild(output);
    var outformat = document.createElement("input");
    outformat.type = "text";
    outformat.name = "outformat" + OutputNumber;
    var outformatText = document.createElement("P");
    outformatText.innerText = "What is the format of the output? (CSV, FITS, JPEG...)"
    container.appendChild(outformatText);
    container.appendChild(outformat);
    var outunit = document.createElement("input");
    outunit.type = "text";
    outunit.name = "unit" + InputNumber;
    var outunitText = document.createElement("P");
    outunitText.innerText = "What is the unit for this output? (mag, eV, T, W...)"
    container.appendChild(outunitText);
    container.appendChild(outunit);
    // Append a line break 
    container.appendChild(document.createElement("br"));
    OutputNumber += 1;
    
}
