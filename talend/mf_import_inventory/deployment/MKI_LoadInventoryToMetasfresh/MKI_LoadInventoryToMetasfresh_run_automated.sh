#!/bin/bash

#title           :MKI_LoadInventoryToMetasfresh.sh
#
#description     :this script will import xml inventory data from a specified source [XML_IN] into an inventory CSV file in path CSV_OUT
#                 to metasfresh generic import (Inventory) REST API. 
#                 After processing, it will move the
#                 processed files in a different folder [XML_OUT].
#                 The CSV file will be kept for diagnostics or information.
#
#note            :make sure [XML_IN] and [XML_OUT] and [CSV_OUT] have sufficient read/write permissions
#                 best used with cron.
#
#author          :pgandert@gandert-edv.de
#date            :2019-09-16
#usage           :./MA_ImportJtlOrdersToMetasFresh_run_automated_run_automated.sh -i [INPUT_LOCATION_XML]
#                                                                   -o [OUTPUT_LOCATION_XML] 
#                                                                   -a [API-KEY_METASFRESH]
#                                                                   -u [SUBDOMAIN_BASE_NAME]
#                                                                   -c [OUTPUT_LOCATION_CSV] 
#===========================================================================================

set -e
set -u

XML_IN=NOTSET
XML_OUT=NOTSET
CSV_OUT=NOTSET
METASFRESH_APIKEY=NOTSET
METASFRESH_URL_NAME=NOTSET



help(){

echo "This is script will run a talend job and will import csv orders to metasfresh order-candidate REST API

Parameters:
    -i    Location of XML files (INPUT)
    -o    Location of XML files (OUTPUT)
    -u    Subdomain-URL Name (eg. live1234)
    -a    API Key for metasfresh API
	-c    Location of CSV files (OUTPUT)
    
Examples:
./MA_ImportJtlOrdersToMetasFresh_run_automated_run_automated.sh -i '/opt/xml/input' -o '/opt/xml/output' -a abc12345defg6789 -u live1234 -c '/opt/csv/output'


"
exit 2

}




function_java(){
    
    # get directory of script and set variable
    # 
    cd `dirname $0`
    ROOT_PATH=`pwd`
    
    java -Xms256M -Xmx1024M -cp .:$ROOT_PATH:$ROOT_PATH/../lib/routines.jar:$ROOT_PATH/../lib/aopalliance-1.0.jar:$ROOT_PATH/../lib/bcprov_1.51.0.jar:$ROOT_PATH/../lib/com.google.guava_15.0.0.v201403281430.jar:$ROOT_PATH/../lib/commons-io-2.4.jar:$ROOT_PATH/../lib/cryptacular-1.1.1.jar:$ROOT_PATH/../lib/cxf-core-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-bindings-soap-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-databinding-jaxb-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-frontend-jaxrs-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-rs-client-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-rs-extension-providers-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-security-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-security-saml-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-transports-http-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-ws-security-3.2.4.jar:$ROOT_PATH/../lib/cxf-rt-wsdl-3.2.4.jar:$ROOT_PATH/../lib/dom4j-1.6.1.jar:$ROOT_PATH/../lib/ehcache-2.10.4.jar:$ROOT_PATH/../lib/filecopy.jar:$ROOT_PATH/../lib/jakarta-oro-2.0.8.jar:$ROOT_PATH/../lib/jasypt-1.9.2.jar:$ROOT_PATH/../lib/javax.annotation_1.2.0.v201401042248.jar:$ROOT_PATH/../lib/javax.ws.rs-api-2.1.jar:$ROOT_PATH/../lib/javax.wsdl_1.6.2.v201012040545.jar:$ROOT_PATH/../lib/jaxen-1.1.1.jar:$ROOT_PATH/../lib/jettison-1.3.8.jar:$ROOT_PATH/../lib/joda-time-2.9.jar:$ROOT_PATH/../lib/log4j-1.2.16.jar:$ROOT_PATH/../lib/neethi-3.1.1.jar:$ROOT_PATH/../lib/opensaml-core-3.3.0.jar:$ROOT_PATH/../lib/opensaml-profile-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-saml-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-saml-impl-3.3.0.jar:$ROOT_PATH/../lib/opensaml-security-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-security-impl-3.3.0.jar:$ROOT_PATH/../lib/opensaml-soap-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-xacml-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-xacml-impl-3.3.0.jar:$ROOT_PATH/../lib/opensaml-xacml-saml-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-xacml-saml-impl-3.3.0.jar:$ROOT_PATH/../lib/opensaml-xmlsec-api-3.3.0.jar:$ROOT_PATH/../lib/opensaml-xmlsec-impl-3.3.0.jar:$ROOT_PATH/../lib/org.apache.commons.codec_1.6.0.v201305230611.jar:$ROOT_PATH/../lib/org.apache.commons.logging_1.2.0.jar:$ROOT_PATH/../lib/org.apache.log4j_1.2.15.v201012070815.jar:$ROOT_PATH/../lib/security-common-7.0.1.jar:$ROOT_PATH/../lib/slf4j-api-1.7.5.jar:$ROOT_PATH/../lib/slf4j-log4j12-1.7.5.jar:$ROOT_PATH/../lib/spring-aop-4.3.10.RELEASE.jar:$ROOT_PATH/../lib/spring-beans-4.3.10.RELEASE.jar:$ROOT_PATH/../lib/spring-context-4.3.10.RELEASE.jar:$ROOT_PATH/../lib/spring-core-4.3.10.RELEASE.jar:$ROOT_PATH/../lib/spring-expression-4.3.10.RELEASE.jar:$ROOT_PATH/../lib/stax-api-1.0-2.jar:$ROOT_PATH/../lib/stax2-api-3.1.4.jar:$ROOT_PATH/../lib/talendcsv.jar:$ROOT_PATH/../lib/woodstox-core-asl-4.4.1.jar:$ROOT_PATH/../lib/wss4j-bindings-2.2.1.jar:$ROOT_PATH/../lib/wss4j-policy-2.2.1.jar:$ROOT_PATH/../lib/wss4j-ws-security-common-2.2.1.jar:$ROOT_PATH/../lib/wss4j-ws-security-dom-2.2.1.jar:$ROOT_PATH/../lib/wss4j-ws-security-policy-stax-2.2.1.jar:$ROOT_PATH/../lib/wss4j-ws-security-stax-2.2.1.jar:$ROOT_PATH/../lib/xmlschema-core-2.2.3.jar:$ROOT_PATH/../lib/xmlsec-2.1.1.jar:$ROOT_PATH/../lib/xpathutil-1.0.0.jar:$ROOT_PATH/mki_loadinventorytometasfresh_0_1.jar:$ROOT_PATH/mki_postcsvtometasfresh_0_1.jar: metas_kasseinventory.mki_loadinventorytometasfresh_0_1.MKI_LoadInventoryToMetasfresh  --context=Default  --context_param csvInPath="${CSV_IN}" --context_param csvOutPath="${CSV_OUT}" --context_param metasfreshApiBaseUrl="https://${METASFRESH_URL_NAME}.metasfresh.com" --context_param metasfreshApiKey="${METASFRESH_APIKEY}" --context_param orgCode="${ORG_CODE}" 
    
}


main(){
    
    # check if in- and output folders exist
    #
    if [[ ! -d ${XML_IN} ]]; then
        echo "[ERROR] Cannot find INPUT folder ${CSV_IN}"
        exit 1
    fi

    if [[ ! -d ${XML_OUT} ]]; then
        echo "[ERROR] Cannot find OUPUT folder ${CSV_OUT}"
        exit 1
    fi

    if [[ ! -d ${CSV_OUT} ]]; then
        echo "[ERROR] Cannot find OUPUT folder ${CSV_OUT}"
        exit 1
    fi

    # execute main java/talend function
    #
    function_java
    
}


while getopts i:o:a:u:c: arg ; do
    case "$arg" in
        a)METASFRESH_APIKEY="$OPTARG"
        ;;
        u)METASFRESH_URL_NAME="$OPTARG"
        ;;
        i)XML_IN="$OPTARG"
        ;;
        o)XML_OUT="$OPTARG"
        ;;
        c)CSV_OUT="$OPTARG"
        ;;
        ?)help
    esac
done

main

exit 0
