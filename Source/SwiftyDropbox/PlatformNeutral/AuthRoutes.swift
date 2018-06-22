///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

/// Routes for the auth namespace
open class AuthRoutes {
    public let client: DropboxTransportClient
    init(client: DropboxTransportClient) {
        self.client = client
    }

    /// Disables the access token used to authenticate the call.
    ///
    ///
    ///  - returns: Through the response callback, the caller will receive a `Void` object on success or a `Void` object
    /// on failure.
    @discardableResult open func tokenRevoke() -> RpcRequest<VoidSerializer, VoidSerializer> {
        let route = Auth.tokenRevoke
        return client.request(route)
    }

}
