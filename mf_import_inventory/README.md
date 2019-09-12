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

