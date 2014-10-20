module.exports =

	# this will be used throughout the app to somewhat ensure security
	# make sure you change this, and make sure not even you rememeber it easily.
	secret: 'r3v1510nm3d1c4v373r1n4r14'
	static: 'http://s3.amazonaws.com/uat-website'
	pdf:
		base : '/revista/'
		url  : 'https://s3-us-west-1.amazonaws.com/uat.magazine'
		opts : '#page=1&zoom=page-fit&twoPageView=2'
