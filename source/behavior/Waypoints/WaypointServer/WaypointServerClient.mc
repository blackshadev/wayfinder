import Toybox.Lang;
import Toybox.Communications;

class WaypointServerClient {
    
    const BASE_URL = "https://wayfinder.littledev.nl";

    public function target() as String {
        return BASE_URL.substring("https://".length(), null);
    }

    public function openDeviceCode(deviceCode as String) as Void {
        var url =  BASE_URL + "/" + deviceCode.toLower();

        Communications.openWebPage(url, null, null);
    }

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

        Communications.makeWebRequest(
            url,
            null, 
            {
                :method => Communications.HTTP_REQUEST_METHOD_PUT,
            }, 
            onComplete
        );
    }

    public function cancelPendingRequests() as Void {
        Communications.cancelAllRequests();
    }
}