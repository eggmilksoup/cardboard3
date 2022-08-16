// formatrcp.go version 3.1.0

package main
import "fmt"
import "os"

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "usage: %s title message\n", os.Args[0])
		os.Exit(1)
	}
	fmt.Println("**Official Vote Thread**\n" + 
	            "RCP " + os.Args[1] + "\n" +
	            os.Args[2] + "\n" +
	            "----------------------------------------\n" + 
	            "@Eldritch Legislators\n" +
	            "Please react to this message with ✅ for a \"yes\" vote or ❌ for a \"no\" vote.")
}
