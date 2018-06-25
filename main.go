package main

import (
	"fmt"
	"os"
	"unicode"

	"github.com/Didstopia/steamer/steamcmd"
)

func main() {
	// Verify that we have arguments
	args := os.Args[1:]
	if len(args) <= 1 {
		fmt.Println("Missing required argument (try adding --appinfo <APP_ID>)")
		os.Exit(1)
	}

	// Verify that we have a valid action
	action := args[0]
	if action == "" || isInt(action) {
		fmt.Println("Invalid argument specified:", action)
		os.Exit(1)
	}

	// Verify that a valid app id was specified
	appID := args[1]
	if appID == "" || !isInt(appID) {
		fmt.Println("Invalid App ID specified:", appID)
		os.Exit(1)
	}

	//fmt.Println("Loading app info for App ID:", appID)

	if action == "--appinfo" {
		fmt.Println(steamcmd.AppInfo(appID))
	} else {
		fmt.Println("Invalid or unsupported argument specified:", action)
		os.Exit(1)
	}
}

func isInt(s string) bool {
	for _, c := range s {
		if !unicode.IsDigit(c) {
			return false
		}
	}
	return true
}
