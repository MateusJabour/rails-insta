//= require controllers/photo_controller
describe("Photo controller", function() {
  it("should be an object", function() {
    expect(PhotoController).not.toBe(undefined);
    expect(typeof PhotoController).toBe('object');
  });

  it("should have a loadEvents function", function() {
    expect(PhotoController.loadEvents).not.toBe(undefined);
    expect(typeof PhotoController.loadEvents).toBe('function');
  });
});
