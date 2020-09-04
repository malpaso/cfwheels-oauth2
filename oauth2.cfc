component accessors="true" {

  /**
   * Accept init parameters and return an oauth2 instance for a given provider
   *
   * [section: Plugins]
   * [category: Authentication]
   *
   * @provider The oauth2 provider to be used eg. 'google'
   * @client_id The oauth2 client_id
   * @client_secret The oauth2 client_secret
   * @authEndpoint The endpoint to use for authentication
   * @accessTokenEndpoint The endpoint to use to get an access token
   * @redirect_uri The url for redirection afterwards
   */
  public oauth2 function init(
    required string provider="oauth2",
    required string client_id, 
		required string client_secret, 
		required string authEndpoint, 
		required string accessTokenEndpoint, 
		required string redirect_uri
  ){
    var basePath = getDirectoryFromPath( getMetadata( this ).path ).replace( '\', '/', 'all' );
    oauthProvider = new 'providers.#arguments.provider#'(arguments);
    return oauthProvider;
  }

  private array function $listProviders( required string basePath ) {
    var resourcePath = basePath & 'providers/';
    var paths = directoryList( resourcePath, true, 'path', '*.cfc' );
    return paths.map( function( path ) {
        return path.replace( '\', '/', 'all' ).replace( resourcePath, '' );
    } );
  }

}