// mkthread.go version 3.1.0

package main
import "fmt"
import "github.com/bwmarrin/discordgo"
import "os"
import "strconv"

func main() {
        if len(os.Args) < 5 {
		fmt.Fprintf(os.Stderr, "usage: %s apikey channel title duration\n", os.Args[0])
		os.Exit(1)
	}
	discord, _ := discordgo.New("Bot " + os.Args[1])
	dur, _ := strconv.Atoi(os.Args[4])
	thread, err :=discord.ThreadStart(os.Args[2], os.Args[3], 11, dur)
	if err != nil {
		fmt.Fprintf(os.Stderr, err.Error())
		os.Exit(1)
	}
	fmt.Println(thread.ID)
}
