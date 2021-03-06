% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/StationFinder.R
\name{findStation}
\alias{findStation}
\title{Find stations near a park or refuge}
\usage{
findStation(unitCode, distance = NULL, climateParameters = NULL,
  filePathAndName = NULL)
}
\arguments{
\item{unitCode}{One NPS unit code or FWS refuge code as a string}

\item{distance}{(optional) Distance (in kilometers) to buffer park bounding box}

\item{climateParameters}{A list of one or more climate parameters (e.g. pcpn, mint, maxt, avgt, obst, snow, snwd). If not specified, defaults to all parameters except degree days. See Table 3 on ACIS Web Services page: \url{http://www.rcc-acis.org/docs_webservices.html}}

\item{filePathAndName}{(optional) File path and name including extension for output CSV file}
}
\value{
A data frame containing station information for stations near the specified park/refuge. See User Guide for more details:  \url{https://docs.google.com/document/d/1B0rf0VTEXQNWGW9fqg2LRr6cHR20VQhFRy7PU_BfOeA/}
}
\description{
Takes one park or refuge organizational code and one or more climate parameters, determines the stations near the specified park/refuge using a bounding box from the IRMA Unit Service (\url{http://irmaservices.nps.gov/v2/rest/unit/CODE/geography?detail=envelope&dataformat=wkt&format=json}). 
If distance parameter is specified, bounding box will be buffered by that distance. If no distance is provided, park bounding box is used. 
Station location must intersect park bounding box (unbuffered or buffered).
Returns station information as a data frame with the following items: name, longitude, latitude, station IDs (sids), state code, elevation (feet), and unique station ID
}
\examples{
\dontrun{
Find stations collecting average temperature within 10km of Marsh-Billings NHP:

findStation(unitCode = "MABI", distance=10, climateParameters=list('avgt'))

Find stations collecting all climate parameters except degree days within 15km of Marsh-Billings NHP:

findStation(unitCode = "MABI", distance=10)

Find stations collecting precipitation or average temperature within 10km of Agate Fossil Beds and save to a CSV file:

findStation(unitCode = "AGFO", distance=10, climateParameters=list('pcpn'), filePathAndName = "agfo_stations.csv")

Find stations within 30km of Rocky Mountain NP collecting maxt and mint:

findStation(unitCode = "ROMO", distance=30, climateParameters=list('pcpn'), filePathAndName = "Test01_R.csv")

Find stations within 50km of Alamosa NWR that collect precipitation data 
 
findStation(unitCode = "FF06RALM00", climateParameters=list('pcpn'), distance = 50)
}
}

