package server

import (
	"net/http"
	"net/url"
	"regexp"
)

var codeValidator = regexp.MustCompile("^[0-9a-zA-Z]{4}$")

type mapParameters struct {
	Code string
}

func (s *Server) mapHandler(w http.ResponseWriter, r *http.Request) {
	code := r.PathValue("code")

	if !codeValidator.MatchString(code) {
		http.Redirect(w, r, "/?error="+url.QueryEscape("Invalid code provided. Expected code of 4 characters long."), http.StatusSeeOther)
		return
	}

	s.ServeTemplate(w, "map.html", mapParameters{Code: code})
}
