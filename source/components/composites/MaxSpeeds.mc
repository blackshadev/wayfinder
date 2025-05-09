import Toybox.Graphics;
import Toybox.Lang;

class MaxSpeeds extends RelativeComponent {
    private var unitConverter as UnitConverter;

    private var title as $.Text;
    private var max2s as $.Text;
    private var max10s as $.Text;
    private var max2sLabel as $.Text;
    private var max10sLabel as $.Text;

    function initialize(unitConverter as UnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.title = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelMaxSpeed
        });
        
        self.max2s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });
        self.max10s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });

        self.max2sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelMaxSpeed2s
        });
        self.max10sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelMaxSpeed10s
        });

        self.setValue(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.title.setOffset(offset);
        self.max2sLabel.setOffset(offset);
        self.max10sLabel.setOffset(offset);
        self.max2s.setOffset(offset);
        self.max10s.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.title,
            new Layout.Row([ self.max2s, self.max2sLabel ]),
            new Layout.Row([ self.max10s, self.max10sLabel ])
        ]);
    }

    function setValue(value as MaxSpeedValues?) as Void {
        if (value == null) {
            self.max2s.setText("--");
            self.max10s.setText("--");
            return;
        }

        var max2s = self.unitConverter.speedFromMS(value.speed2s);
        var max10s = self.unitConverter.speedFromMS(value.speed10s);

        self.max2s.setText(max2s.format("%.01f"));
        self.max10s.setText(max10s.format("%.01f"));
    }

    function layout(dc as Dc) as Void {

        self.title.layout(dc);

        self.max2sLabel.layout(dc);
        self.max10sLabel.layout(dc);

        System.println(self.title.height());

        var w = self.max10sLabel.calculateTextWidth(dc);
        self.max2s.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);
        self.max10s.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);

        self.max2s.layout(dc);
        self.max10s.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.title.draw(dc);
        
        self.max2s.draw(dc);
        self.max10s.draw(dc);

        self.max2sLabel.draw(dc);
        self.max10sLabel.draw(dc);
    }
}