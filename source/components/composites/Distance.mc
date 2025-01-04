import Toybox.Graphics;
import Toybox.Lang;

class Distance extends RelativeComponent {

    private var title as $.Text;
    private var value as $.Text;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();
        
        self.title = new $.Text({
            :offset => [offset[0], offset[1]],
            :font => Graphics.FONT_XTINY,
            :color => Graphics.COLOR_LT_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => "Distance"
        });
        
        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_MEDIUM, 
            :color => Graphics.COLOR_WHITE, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });

        self.setValue(null);
    }

    function setValue(distance as Float?) as Void {
        if (distance == null) {
            self.value.setText("--");
            return;
        }

        var format = "%.01f";
        if (distance < 1000.0) {
            format = "%0.2f";
        }
        if (distance < 0.0) {
            distance = 0.0;
        }

        self.value.setText((distance / 1000).format(format));
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.title.setOffset(offset);
        self.value.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([self.title, self.value]);
    }

    function layout(dc as Dc) as Void {

        self.title.layout(dc);
        self.value.layout(dc);
    }

    function draw(dc as Dc) as Void {        
        self.title.draw(dc);
        self.value.draw(dc);
    }
}