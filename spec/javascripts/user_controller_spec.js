//= require controllers/user_controller
describe("Relationship controller", function() {

  it("will be an object", function() {
    expect(UserController).not.toBe(undefined);

    expect(typeof UserController).toBe('object');
  });

  it("will have a loadEvents function", function () {
    expect(UserController.loadEvents).not.toBe(undefined);

    expect(typeof UserController.loadEvents).toBe('function');
  });
});
