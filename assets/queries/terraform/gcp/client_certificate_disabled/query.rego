package Cx

import data.generic.terraform as tf_lib
import data.generic.common as common_lib

CxPolicy[result] {
	resource := input.document[i].resource.google_container_cluster[primary]
	not resource.master_auth

	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_container_cluster",
		"resourceName": tf_lib.get_resource_name(resource, primary),
		"searchKey": sprintf("google_container_cluster[%s]", [primary]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "Attribute 'master_auth' is defined",
		"keyActualValue": "Attribute 'master_auth' is undefined",
		"searchLine": common_lib.build_search_line(["resource", "google_container_cluster", primary],[]),
	}
}

CxPolicy[result] {
	resource := input.document[i].resource.google_container_cluster[primary]
	resource.master_auth
	not resource.master_auth.client_certificate_config

	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_container_cluster",
		"resourceName": tf_lib.get_resource_name(resource, primary),
		"searchKey": sprintf("google_container_cluster[%s].master_auth", [primary]),
		"issueType": "MissingAttribute",
		"keyExpectedValue": "Attribute 'client_certificate_config' in 'master_auth' is defined",
		"keyActualValue": "Attribute 'client_certificate_config' in 'master_auth' is undefined",
		"searchLine": common_lib.build_search_line(["resource", "google_container_cluster", primary, "master_auth"],[]),
	}
}

CxPolicy[result] {
	resource := input.document[i].resource.google_container_cluster[primary]
	resource.master_auth
	resource.master_auth.client_certificate_config.issue_client_certificate == false

	result := {
		"documentId": input.document[i].id,
		"resourceType": "google_container_cluster",
		"resourceName": tf_lib.get_resource_name(resource, primary),
		"searchKey": sprintf("google_container_cluster[%s].master_auth.client_certificate_config.issue_client_certificate", [primary]),
		"issueType": "IncorrectValue",
		"keyExpectedValue": "Attribute 'issue_client_certificate' in 'client_certificate_config' is true",
		"keyActualValue": "Attribute 'issue_client_certificate' in 'client_certificate_config' is false",
		"searchLine": common_lib.build_search_line(["resource", "google_container_cluster", primary, "master_auth", "client_certificate_config", "issue_client_certificate"],[]),
		"remediation": json.marshal({
			"before": "false",
			"after": "true"
		}),
		"remediationType": "replacement",
	}
}
