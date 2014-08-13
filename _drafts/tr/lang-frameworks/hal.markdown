# HAL

We see lots of teams creating RESTful interfaces without paying any attention to hypermedia. HAL (stateless. co/hal_specification.html) is a simple format for incorporating hyperlinks into JSON representations which is easy to implement an consume. HAL is well supported by libraries for parsing and representing JSON, and there are HAL-aware REST client libraries such as Hyperclient (github.com/codegram/hyperclient) which make it easy to navigate resources by following links.

