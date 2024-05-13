/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

/*
 {
   "data": [
     {
       "name": "vexere",
       "img": "https://media.dev.uniservice.vn/logo_vexere.png",
       "url": "https://uat-api.vexere.net/agent/webview/home?client_id=63950932-a8a3-40b6-bf17-b49d29d7789f",
       "devices": {
         "android": true,
         "ios": true
       }
     }
   ],
   "message": "Success",
   "code": 200,
   "settings": {
     "androidAppVersion": "1.0.0",
     "iosAppVersion": "1.0.0"
   }
 }
 */

enum ServicesType {
  static let vexere:String = "VEXERE"
}

struct Service : Mappable, Identifiable {
    var id: String?
	var name : String?
	var img : String?
    var key : String?
	var url : String?
    var actionLabel : String = ""
	var devices : Devices?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		name <- map["name"]
		img <- map["img"]
		url <- map["url"]
        key <- map["key"]
        actionLabel <- map["actionLabel"]
		devices <- map["devices"]
	}

}

struct Devices : Mappable {
    var android : Bool?
    var ios : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        android <- map["android"]
        ios <- map["ios"]
    }

}
