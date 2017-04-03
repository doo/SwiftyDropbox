//
//  ScanbotAddition.swift
//  SwiftyDropbox
//
//  Created by Constantine Fry on 03.04.17.
//  Copyright © 2017 Dropbox. All rights reserved.
//

import Foundation

extension FilesRoutes {
    
    public func scanbot_getUploadRequest(path: String, mode: Files.WriteMode = .add, autorename: Bool = false,
                                         clientModified: Date? = nil, mute: Bool = false, input: URL) -> URLRequest? {
        let route = Files.upload
        let serverArgs = Files.CommitInfo(path: path, mode: mode, autorename: autorename,
                                          clientModified: clientModified, mute: mute)
        return self.client.scanbot_request(route, serverArgs: serverArgs, input: .file(input))
    }
    
}

extension DropboxTransportClient {
    
    func scanbot_request<ASerial: JSONSerializer, RSerial: JSONSerializer, ESerial: JSONSerializer>(
        _ route: Route<ASerial, RSerial, ESerial>, serverArgs: ASerial.ValueType, input: UploadBody) -> URLRequest? {
        
        let host = route.attrs["host"]! ?? "api"
        let url = "\(self.baseHosts[host]!)/\(route.namespace)/\(route.name)"
        let routeStyle: RouteStyle = RouteStyle(rawValue: route.attrs["style"]!!)!
        
        let jsonRequestObj = route.argSerializer.serialize(serverArgs)
        let rawJsonRequest = SerializeUtil.dumpJSON(jsonRequestObj)
        
        let headers = self.getHeaders(routeStyle, jsonRequest: rawJsonRequest, host: host)
        
        return try? URLRequest(url: url, method: .post, headers: headers)
    }

}
