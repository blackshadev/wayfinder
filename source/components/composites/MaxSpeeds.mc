import Toybox.Graphics;
import Toybox.Lang;

class MaxSpeeds extends RelativeComponent {
    private var unitConverter as UnitConverter;

    private var title as $.Text;
    private var avg2s as $.Text;
    private var avg10s as $.Text;
    private var avg2sLabel as $.Text;
    private var avg10sLabel as $.Text;

    function initialize(unitConverter as UnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.title = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelAvgSpeed
        });
        
        self.avg2s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });
        self.avg10s = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });

        self.avg2sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelAvgSpeed2s
        });
        self.avg10sLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelAvgSpeed10s
        });

        self.setValue(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.title.setOffset(offset);
        self.avg2sLabel.setOffset(offset);
        self.avg10sLabel.setOffset(offset);
        self.avg2s.setOffset(offset);
        self.avg10s.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.title,
            new Layout.Row([ self.avg2s, self.avg2sLabel ]),
            new Layout.Row([ self.avg10s, self.avg10sLabel ])
        ]);
    }

    function setValue(value as AverageSpeedValues?) as Void {
        if (value == null) {
            self.avg2s.setText("--");
            self.avg10s.setText("--");
            return;
        }

        var avg2s = self.unitConverter.speedFromMS(value.speed2s);
        var avg10s = self.unitConverter.speedFromMS(value.speed10s);

        self.avg2s.setText(avg2s.format("%.01f"));
        self.avg10s.setText(avg10s.format("%.01f"));
    }

    function layout(dc as Dc) as Void {

        self.title.layout(dc);

        self.avg2sLabel.layout(dc);
        self.avg10sLabel.layout(dc);

        System.println(self.title.height());

        var w = self.avg10sLabel.calculateTextWidth(dc);
        self.avg2s.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);
        self.avg10s.updateOffset(self._offset[0] - w - Utils.Sizing.spacingL, null);

        self.avg2s.layout(dc);
        self.avg10s.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.title.draw(dc);
        
        self.avg2s.draw(dc);
        self.avg10s.draw(dc);

        self.avg2sLabel.draw(dc);
        self.avg10sLabel.draw(dc);
    }
}