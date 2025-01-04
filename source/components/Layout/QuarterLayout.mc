import Toybox.Lang;
import Toybox.Graphics;

class QuarterLayout extends Component {
    private var background as Component;

    private var tl as RelativeComponent;
    private var tr as RelativeComponent;
    private var br as RelativeComponent;
    private var bl as RelativeComponent;

    public function initialize(
        tl as RelativeComponent, 
        tr as RelativeComponent, 
        br as RelativeComponent, 
        bl as RelativeComponent
    ) {
        Component.initialize();
        
        self.background = new QuarterBackground();

        self.tl = tl;
        self.tr = tr;
        self.br = br;
        self.bl = bl;

        var offset = Utils.Sizing.offset;

        tl.setOffset([ -offset, -offset ]);
        tr.setOffset([ offset, -offset ]);
        br.setOffset([ offset, offset ]);
        bl.setOffset([ -offset, offset ]);
    }

    public function layout(dc as Dc) as Void {
        self.background.layout(dc);
        
        self.tl.layout(dc);
        self.tr.layout(dc);
        self.br.layout(dc);
        self.bl.layout(dc);
    }

    public function draw(dc as Dc) as Void {
        self.background.draw(dc);
        
        self.tl.draw(dc);
        self.tr.draw(dc);
        self.br.draw(dc);
        self.bl.draw(dc);
    }
}