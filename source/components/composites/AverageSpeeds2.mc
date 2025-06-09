import Toybox.Graphics;
import Toybox.Lang;

class AverageSpeeds2 extends RelativeComponent {
    private var unitConverter as SettingsBoundUnitConverter;

    private var avg30m as $.Text;
    private var avg30mLabel as $.Text;
    private var avg60m as $.Text;
    private var avg60mLabel as $.Text;
    private var topOffset as Layout.Offset;

    function initialize(unitConverter as SettingsBoundUnitConverter, offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.unitConverter = unitConverter;

        self.topOffset = new Layout.Offset({
            :offset => [offset[0], offset[1]],
            :size => [0, Utils.Fonts.getFontHeight(Graphics.FONT_XTINY)]
        });
        self.avg30m = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });
        self.avg60m = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_GLANCE_NUMBER, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT
        });

        self.avg30mLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelAvgSpeed30m
        });
        self.avg60mLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Utils.Fonts.extraTinyFont(), 
            :color => Utils.Colors.greyBackground, 
            :justification => Graphics.TEXT_JUSTIFY_LEFT,
            :text => Rez.Strings.labelAvgSpeed60m
        });

        self.setAvgSpeeds(null);
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.topOffset.setOffset(offset);
        self.avg30mLabel.setOffset(offset);
        self.avg30m.setOffset(offset);
        self.avg60mLabel.setOffset(offset);
        self.avg60m.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([
            self.topOffset,
            new Layout.Row([ self.avg30mLabel, self.avg30m ]),
            new Layout.Row([ self.avg60mLabel, self.avg60m ])
        ]);
    }

    function setAvgSpeeds(speeds as AverageSpeedValues?) as Void {
        if (speeds == null) {
            self.avg30m.setText("--");
            self.avg60m.setText("--");
            return;
        }

        var avg30m = self.unitConverter.speedFromMS(speeds.speed30m.value);
        self.avg30m.setText(avg30m.format("%.01f"));

        var avg60m = self.unitConverter.speedFromMS(speeds.speed60m.value);
        self.avg60m.setText(avg60m.format("%.01f"));
    }


    function layout(dc as Dc) as Void {
        self.avg30mLabel.layout(dc);
        self.avg60mLabel.layout(dc);

        var w = self.avg60mLabel.calculateTextWidth(dc);
        self.avg30m.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);
        self.avg60m.updateOffset(self._offset[0] + w + Utils.Sizing.spacingL, null);

        self.avg30m.layout(dc);
        self.avg60m.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.avg30m.draw(dc);
        self.avg60m.draw(dc);

        self.avg30mLabel.draw(dc);
        self.avg60mLabel.draw(dc);
    }
}