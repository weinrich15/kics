package Cx

import data.generic.common as common_lib
import data.generic.cloudformation as cf_lib

CxPolicy[result] {
	document := input.document[i]
	resource = document.Resources[name]
	resource.Type == "AWS::Lambda::Function"
	properties := resource.Properties
	not common_lib.valid_key(properties, "DeadLetterConfig")

	result := {
		"documentId": document.id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("'Resources.%s.Properties.DeadLetterConfig' is defined and not null", [name]),
		"keyActualValue": sprintf("'Resources.%s.Properties.DeadLetterConfig' is undefined or null", [name]),
		"searchLine": common_lib.build_search_line(["Resources", name, "Properties"], []),
	}
}

CxPolicy[result] {
	document := input.document[i]
	resource = document.Resources[name]
	resource.Type == "AWS::Lambda::Function"
	properties := resource.Properties

	not common_lib.valid_key(properties.DeadLetterConfig, "TargetArn")

	result := {
		"documentId": document.id,
		"resourceType": resource.Type,
		"resourceName": cf_lib.get_resource_name(resource, name),
		"searchKey": sprintf("Resources.%s.Properties.DeadLetterConfig", [name]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": sprintf("'Resources.%s.Properties.DeadLetterConfig.TargetArn' is defined and not null", [name]),
		"keyActualValue": sprintf("'Resources.%s.Properties.DeadLetterConfig.TargetArn' is undefined or null", [name]),
		"searchLine": common_lib.build_search_line(["Resources", name, "Properties", "DeadLetterConfig"], []),
	}
}
