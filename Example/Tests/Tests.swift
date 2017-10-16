// https://github.com/Quick/Quick

import Quick
import Nimble
import Nimble_Snapshots
import VerticalSteppedSlider

class TestVSSlider: QuickSpec {
    
    override func spec() {
        describe("slider") {
            let frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            var slider: VSSlider!

            beforeEach {
                slider = VSSlider(frame: frame)
                slider.minimumValue = -1
                slider.maximumValue = 1
                slider.increment = 0.25
                slider.value = 0
            }
            
            it("width") {
                slider.trackWidth = 10
                expect(slider) == snapshot()
            }
            
            it("colors") {
                slider.maximumTrackTintColor = .green
                slider.minimumTrackTintColor = .red
                expect(slider) == snapshot()
            }
            
            it("track img") {
                slider.maximumTrackImage = #imageLiteral(resourceName: "max-track")
                slider.minimumTrackImage = #imageLiteral(resourceName: "min-track")
                slider.trackWidth = 10
                expect(slider) == snapshot()
            }
            
            it("not extended under thumb") {
                slider.trackExtendsUnderThumb = false
                expect(slider) == snapshot()
            }
            
            it("ascending") {
                slider.ascending = true
                expect(slider) == snapshot()
            }
            
            it("thumb img") {
                slider.thumbImage = #imageLiteral(resourceName: "thumb")
                expect(slider) == snapshot()
            }
            
            it("thumb color") {
                slider.thumbTintColor = .purple
                expect(slider) == snapshot()
            }
            
            it("colors and width") {
                slider.maximumTrackTintColor = .green
                slider.minimumTrackTintColor = .red
                slider.trackWidth = 10
                expect(slider) == snapshot()
            }
            
            it("marks") {
                slider.increment = 0.1
                slider.markColor = .yellow
                slider.markWidth = 3
                expect(slider) == snapshot()
            }
            
            it("no marks") {
                slider.increment = 0
                slider.markColor = .yellow
                slider.markWidth = 3
                expect(slider) == snapshot()
            }
            
            it("horizontal") {
                slider.vertical = false
                slider.maximumTrackTintColor = .green
                slider.minimumTrackTintColor = .red
                slider.trackWidth = 10
                expect(slider) == snapshot()
            }
            
            it("set value") {
                slider.value = 0.25
                expect(slider.value).toEventually(equal(0.25))
            }
            
            it("round value") {
                slider.value = 0.4
                expect(slider.roundedValue).toEventually(equal(0.5))
            }
            
            it("update increment") {
                slider.value = 0.75
                slider.increment = 1
                expect(slider.roundedValue).toEventually(equal(1))
            }
            
            it("no rounding") {
                slider.increment = 0
                slider.value = 0.4
                expect(slider.roundedValue).toEventually(equal(0.4))
            }
        }
    }
    
}
