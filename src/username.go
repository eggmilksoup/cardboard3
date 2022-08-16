// username.go version 3.1.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey [userid]\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	if len(os.Args) == 2 {
		var id string
		for true {
			_, err := fmt.Scanln(id) 
			if err != nil {
				break
			}
			usr, _ := discord.User(id)
			fmt.Println(usr.Username)
		}
	} else {
		for i := 2; i < len(os.Args); i ++ {
			usr, _ := discord.User(os.Args[i])
			fmt.Println(usr.Username)
		}
	}
}
