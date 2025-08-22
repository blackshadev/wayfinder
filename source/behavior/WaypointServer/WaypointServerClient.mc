import Toybox.Lang;
import Toybox.Communications;

class WaypointServerClient {
    
    const BASE_URL = "https://736c9065855a.ngrok-free.app";
    
    public function registerDevice(
        onComplete as Method(statusCode as Number, data as Dictionary) as Void
    ) as Void {
        Communications.makeWebRequest(
            BASE_URL + "/api/device",
            null, 
            {
                :method => Communications.HTTP_REQUEST_METHOD_POST,
            }, 
            onComplete
        );
    }

    public function getDeviceWaypoints(
        code as String, 
        onComplete as Method(statusCode as Number, data as Dictionary) as Void
    ) as Void {
        var url = BASE_URL + "/api/device/" + code.toLower();

        System.println(url);
        Communications.makeWebRequest(
            url,
            null, 
            {
                :method => Communications.HTTP_REQUEST_METHOD_PUT,
            }, 
            onComplete
        );
    }
}