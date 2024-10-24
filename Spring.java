@RestController
public class HelloController {

    @GetMapping("/greet")
    public String greet(
        @RequestParam(
            value = "name",
            defaultValue = "Guest"
            )
        String name) {
        return String.
        format("Hello, %s!", name);
    }

    @PostMapping("/add")
    public int add(
        @RequestBody AddRequest request)
         {
        return 
        request.getA() + request.getB();
    }
}

