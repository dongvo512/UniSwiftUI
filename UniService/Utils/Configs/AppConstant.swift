//
//  AppConstant.swift
//  UniService
//
//  Created by Admin on 10/01/2024.
//

import Foundation

struct AppConstant {
    
}

struct AppMenu {
    static let TODAY_MENU = "TODAY"
}

struct ApiUrl {
    static let new_access_token = "/api/v1/auth/refresh"
    
    static let menu_today = "/api/v1/menu?menu=TODAY"
    static let menu_drinks = "/api/v1/menu?menu=DRINK"
    static let menu_foodcourt = "/api/v1/menu?menu=FOODCOURT"
    static let menu_specical_food = "/api/v1/menu?menu=SPECIALITY"
    static let menu_neccessary = "/api/v1/menu?menu=NECESSITY"
    static let promotions = "/api/v1/banners/all"
    
    static let cart_normal = "/api/v1/carts?order=NORMAL"
    
    static let services = "/api/v1/services"
    
    static let login = "/api/v1/auth/login"
    
    static let user_info = "/api/v1/auth/me"
    
    static let logout = "/api/v1/auth/logout"
    
    static let branchs = "/api/v1/branches/options?o=true"
    
    static let transactions = "/api/v1/users/user-history?page=%d&limit=%d&order=DESC&field=createdAt&fromDate=%@&toDate=%@"
    
    static let transaction_with_type = "/api/v1/users/user-history?page=%d&limit=%d&order=DESC&type=%@&field=createdAt&fromDate=%@&toDate=%@"
    static let order_bill_detail  = "/api/v1/orders/%@"
    static let payemnt_order  = "/api/v1/orders"
    static let add_product_to_cart  = "/api/v1/carts"
}

struct StatusCode {
    static let CODE_FORBIDDEN = 403
    static let CODE_VALIDATE_DATA = 422
    static let CODE_ERROR_DATA = 404
    static let CODE_BAD_REQUEST_DATA = 400
    static let CODE_EXPIRED_AUTH = 401
    static let CODE_SUCCESS = 200
    static let CODE_SUCCESS_2 = 201
    static let CODE_ERROR = 500
    static let CODE_PAYMENT_FAIL = 409
    static let CODE_PAYMENT_FAIL_2 = 408
    static let CODE_OTP_DELAYING = 410
    static let CODE_ADD_MORE_INFO = 411
    static let CODE_BRANCH_INVALID = 412
}
