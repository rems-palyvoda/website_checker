This script checks response of given web sites.
Input from csv.file, output into csv file.
In case when given url does not have an protocol (google.com instead of https:/google com)
script could add http:// or https:// protocols on your choice.
You can use one of two http clients: Faraday or Typhoeus.
In the current version the main difference is that Typhoeus could follow redirects
whereas Faraday returns status 3xx.

Performance:

Processor 2,6 GHz 6-Core Intel Core i7
- 50 sites Faraday handles approximately in 20 seconds
- 50 sites Typhoeus handles approximately in 20 seconds

In the future:
Try to parallelize processes into threads if input list is too long.

First of all:
`bundle install`

To run tests:
`rake test`

To run script:
`rake run`

To run script with options:
`rake interative`

