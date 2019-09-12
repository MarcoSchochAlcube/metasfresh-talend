[![license](https://img.shields.io/badge/license-GPL-blue.svg)](https://github.com/metasfresh/metasfresh/blob/master/LICENSE.md)

metasfresh is a responsive, Free and Open Source ERP System.  
The Talend Jobs are the Swiss knife for moving data between metasfresh and the world outside.

Talend-Job:mf_import_inventory


This project handles the import of inventory data to metasfresh using the generic import feature.  
The flow ist as follows:  
xml-file -> csv-file -> POST of file-content to metasfresh  

important is, that the structure of the csv file is matching the structur of the "Inventory" import-definition in metasfresh.

The subfolder development contains the Talend Studio project  
The deployment folder contains the stuff for deploying the talend job as standalone job.

##Format of xml file

    <?xml version="1.0" encoding="ISO-8859-1"?>
    <inventuren>
    	<filiale nummer="13">
    		<inventur nummer="201902" datum="20190108">
    			<artikel nummer="11" menge="165.00"/>
    			<artikel nummer="14" menge="245.00"/>
    		</inventur>
    	</filiale>
    </inventuren>

##Format of csv file

    13;08.01.2019;val-209;0.00;201902-13;201902-13-209
    13;08.01.2019;val-210;0.00;201902-13;201902-13-210
    13;08.01.2019;val-111516;0.00;201902-13;201902-13-111516
    13;08.01.2019;val-111517;0.00;201902-13;201902-13-111517

Field 1: stock number  
Field 2: date of inventory  
Field 3: articelnumber with additional prefix 'val-'  
Field 4: counted amount  
Field 5: externalHeaderId  
Field 6: externalLineId  
