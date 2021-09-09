webix.ui({
"rows": [
		{
			"view": "toolbar",
			"css": "webix_dark",
			"paddingX": 5,
			"cols": [
				{ "view": "icon", "icon": "wxi-clock" },
				{ "view": "label", "label": "CALLISTO - Virtual Research Environment - Bêta version" },
				{ "view": "button", "label": "Close", "width": 80 }
			]
		},
		{
			"view": "form",
			"margin": 40,
			"rows": [
				{
					"margin": 20,
					"cols": [
						{
							"margin": 10,
							"rows": [
								{ "view": "template", "type": "section", "template": "Connect to a repository" },
								{ "view": "text", "label": "User", "labelWidth": 100 },
								{ "label": "Password", "view": "text", "height": 35, "labelWidth": 100 }
							]
						},
						{
							"margin": 10,
							"rows": [
								{ "view": "template", "type": "section", "template": "Repository operation" },
								{
									"view": "radio",
									"label": "Operation",
									"value": "Arial",
									"options": [
										"Advanced query",
										" Workflow composition",
										" Register a service"
									],
									"labelWidth": 130,
									"height": 0
								},
								{ "view": "text", "label": "Font Size (px)", "value": "14", "labelWidth": 130, "height": 0 },
								{ "view": "colorpicker", "label": "Background", "value": "#CE9EFF", "labelWidth": 130, "height": 0 },
								{ "view": "colorpicker", "label": "Font Color", "value": "#6C6C6C", "labelWidth": 130, "height": 0 },
								{ "view": "colorpicker", "label": "Header Font", "value": "#00004C", "labelWidth": 130, "height": 0 },
								{ "view": "checkbox", "value": 1, "label": "Material Icons", "labelWidth": 130, "height": 0 }
							]
						}
					],
					"height": 135
				},
				{
					"margin": 10,
					"cols": [
						{ "view": "template", "template": " ", "role": "placeholder", "borderless": true },
						{ "view": "button", "css": "webix_primary", "label": "Connect to repository", "align": "right", "width": 200 },
						{ "label": "Direct access: Jupyter Hub", "view": "button", "height": 36, "width": 250 }
					]
				}
			]
		}
	]
});
