# Table of Contents

- [Structure of the Repository](#structure-of-the-repository)
- [Administration Spatial Data](#administration-spatial-data)
  * [Data Source](#data-source)
  * [Data Process and Final Output](#data-process-and-final-output)
- [Prio-Grid and Pro-Grid-Admin Data](#prio-grid-and-pro-grid-admin-data)
  * [Data Source](#data-source-1)
  * [Data Process and Final Output](#data-process-and-final-output-1)
- [Settlement Data](#settlement-data)



# Structure of the Repository

This repository contains the following files used to build the spatial knowledge graph. In the sections below, we detail the data sources and processing steps.

1. CountryFiles: contains administrative information at different levels, including admin 0 (country), admin 1 (e.g., province or state), and admin 2 (e.g., city or county), along with their relationships.

2. PgcFiles: includes mappings between the lowest-level administrative names and PRIO-GRID data.

3. SettlementCountryFiles: contains concept and relationship files that link human settlement data to the lowest-level administrative divisions.

4. GlobalConcepts and GlobalEdges files contain continents and country nodes and their attributes and spatial relation between the two.


# Administration Spatial Data

## Data Source

All administrative spatial files are sourced from GADM, which can be accessed [here](https://gadm.org/). Alternatively, If you are a R user, you can download these files using the R package “[geodata](https://github.com/rspatial/geodata).” 

If you want to merge your own data with our processed administrative data, you can access it [here](https://www.dropbox.com/scl/fo/rxruup0zl37mvqajsdz1f/ABlv70ASzZRBf-HwBNTGxkw?rlkey=onsoeozu15jojyr6mv0elhkqs&dl=0). The files admin0_gadm, admin1_gadm, and admin2_gadm represent geospatial data for the country level, administrative level 1, and administrative level 2, respectively.

## Data Process and Final Output

GeoBoundaryProcess.Rmd file in the DataPrepare folder provides a detailed step-by-step process used to construct administrative spatial concepts and relationships. Each YAML file in CountryFiles and GlobalConcept(Edges) are named following the convention: Country Name + Concept (Edges). 


### Concept Files

GADM provides unique GID associate with each administrations, you can find there rules [here](https://gadm.org/metadata.html). To indicate the administrative level associated with each region, we generate a unique concept ID by concatenating the GID with its corresponding administrative level. For example, AFG.1.11_1_Adm2 is a combination of the GADM GID "AFG.1.11_1" and its administrative level "Adm2".

Each concept id in ConceptFiles has the following attributes:

- GID: the original GID from GADM

- admin_name (continent_name): the official administrative name. If the unit is at admin level 0, this represents the country name; otherwise, it may represent the continent name.

- iso3c: ISO 3166-1 alpha-3 country code.

- country_name: he official name of the country.

- admin_level: The administrative level of the unit.

### Edge Files

Edge files represent the relationships between administrative units and their corresponding higher-level administrative units. These relationships are defined using the unique concept id we created.

# Prio-Grid and Pro-Grid-Admin Data

## Data Source

Grid-cell data comes from [PRIO-GRID](https://grid.prio.org/#/).

## Data Process and Final Output

The Function_Admin_GridCell.Rmd file in the DataPrepare folder outlines our process for mapping PRIO-GRID data to the lowest administrative units. 

Briefly, we use the following hierarchical plurality rule to assign each grid cell to an administrative unit:
	
1. Admin2 Level: Each grid cell is assigned to the Admin2 unit with which it has the largest area of overlap.
2. Admin1 Level: Any grid cells that remain unassigned in the previous step are assigned to the Admin1 unit with the largest overlap.
3. Admin0 Level: Finally, any remaining unmatched grid cells are assigned to the Admin0 unit.

Each YAML file in PgcFiles is named following the convention: Country iso3 code + Pgc(Edges). 

Each node in the concept yaml file is a combination of Prio-Grid ID + string Pgc. And they have the 
following attributes: 

- GID: the original GID from GADM that you can use to match with GADM spatial geometry 

- conceptID: the concept id we created in the administration spatial data so that you can match with data from 
CountryFiles. 

- admin_name: the official administrative name.

- country_name: he official name of the country.

- admin_level: The administrative level of the unit.


# Settlement Data 

Data comes from [Global Urban Polygons and Points Dataset (GUPPD)](https://earthdata.nasa.gov/data/catalog/sedac-ciesin-sedac-uspat-guppd-v1-1.00). 





