package scheduler

import (
	"time"
)

type Scheduler struct {
	interval time.Duration
	done     chan bool
	ticker   *time.Ticker
	function func()
}

func Create(interval time.Duration, function func()) *Scheduler {
	return &Scheduler{
		interval: interval,
		done:     make(chan bool),
		ticker:   time.NewTicker(interval),
		function: function,
	}
}

func (sch *Scheduler) SetFunction(function func()) {
	sch.function = function
}

func (sch *Scheduler) Start() {
	go sch.run()
}

func (sch *Scheduler) Stop() {
	sch.ticker.Stop()
	sch.done <- true
}

func (sch *Scheduler) run() {
	for {
		select {
		case <-sch.done:
			return
		case <-sch.ticker.C:
			if sch.function != nil {
				sch.function()
			}
		}
	}
}
