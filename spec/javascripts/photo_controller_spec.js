//= require controllers/photo_controller
describe("Photo controller",function (){

  it("will be an object",function (){
    expect(PhotoController).not.toBe(undefined);

    expect(typeof PhotoController).toBe('object');
  });

  it("will have a loadEvents function",function (){
    expect(PhotoController.loadEvents).not.toBe(undefined);

    expect(typeof PhotoController.loadEvents).toBe('function');
  });
});
