package main

import (
	"fmt"
	"sync"
)

func worker(
    id int, 
    wg *sync.WaitGroup, 
    jobs <-chan int) {
	
        defer wg.Done()
	for job := range jobs {
		fmt.Printf
        ("Worker %d processing job %d\n", id, job)
	}
}

func main() {
	var wg sync.WaitGroup
	jobs := make(chan int, 10)

	// Start 3 workers
	for w := 1; w <= 3; w++ {
		wg.Add(1)
		go worker(w, &wg, jobs)
	}

	// Send 5 jobs
	for j := 1; j <= 5; j++ {
		jobs <- j
	}
	close(jobs)

	wg.Wait()
}
