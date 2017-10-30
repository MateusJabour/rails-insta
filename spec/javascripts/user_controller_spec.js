//= require controllers/user_controller
describe("User controller", function() {
  it("should be an object", function() {
    expect(UserController).not.toBe(undefined);
    expect(typeof UserController).toBe('object');
  });

  it("should have a loadEvents function", function () {
    expect(UserController.loadEvents).not.toBe(undefined);
    expect(typeof UserController.loadEvents).toBe('function');
  });
});
