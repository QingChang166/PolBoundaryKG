GNfindNearby = function(lat, lng, featureCode){
  plist <- list(lat = lat, lng = lng, featureCode = featureCode)
  url="http://api.geonames.org/findNearbyJSON?"
  if(!is.null(options()$geonamesUsername)){
    plist[["username"]]=options()$geonamesUsername
  }else{
    warning("No geonamesUsername set. See http://geonames.wordpress.com/2010/03/16/ddos-part-ii/ and set one with options(geonamesUsername=\"foo\") for some services to work")
  }
  
  olist = list()
  for(p in 1:length(plist)){
    olist[[p]]=paste(names(plist)[p],"=",utils::URLencode(as.character(plist[[p]]),reserved=TRUE),sep="")
  }
  pstring=paste(unlist(olist),collapse="&")
  url=paste(url,pstring,sep='')  
  u=url(url,open="r")
  d=readLines(u,warn=FALSE)
  close(u)
  data = rjson::fromJSON(d)
  if(length(data$status)>0){
    stop(paste("error code ",data$status$value," from server: ",data$status$message,sep=""))
  }
  return(data)
}
