import Toybox.Graphics;
import Toybox.Lang;

class Distance extends RelativeComponent {
    private var unitConverter as UnitConverter;

    private var title as $.Text;
    private var value as $.Text;

    function initialize(unitConverter as UnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;
        
        self.title = new $.Text({
            :offset => [offset[0], offset[1]],
            :font => Graphics.FONT_XTINY,
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelDistance
        });
        
        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_MEDIUM, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });

        self.setValue(null);
    }

    function setValue(distance as Float?) as Void {
        if (distance == null) {
            self.value.setText("--");
            return;
        }

        distance = self.unitConverter.distanceFromMeters(distance);

        var format = "%.01f";
        if (distance < 10.0) {
            format = "%0.2f";
        }
        if (distance < 0.0) {
            distance = 0.0;
        }

        self.value.setText(distance.format(format));
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