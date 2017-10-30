//= require controllers/relationship_controller
describe("Relationship controller", function() {
  it("should be an object", function() {
    expect(RelationshipController).not.toBe(undefined);
    expect(typeof RelationshipController).toBe('object');
  });

  it("should have a loadEvents function", function() {
    expect(RelationshipController.loadEvents).not.toBe(undefined);
    expect(typeof RelationshipController.loadEvents).toBe('function');
  });
});
