import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "light", "dark" ]

  connect() {
    const theme = localStorage.getItem('theme')
    if (theme === 'dark'){
      this.lightTarget.classList = "button"
      this.darkTarget.classList = "button is-info is-selected"
    } else if (theme === 'light') {
      this.darkTarget.classList = "button"
      this.lightTarget.classList = "button is-info is-selected"  
    }
  }

  dark() {
    localStorage.setItem('theme', 'dark')
    this.lightTarget.classList = "button"
    this.darkTarget.classList = "button is-info is-selected"
    document.getElementById('application-theme').setAttribute("data-theme", 'dark')
  }

  light() {
    localStorage.setItem('theme', 'light')
    this.darkTarget.classList = "button"
    this.lightTarget.classList = "button is-info is-selected"
    document.getElementById('application-theme').setAttribute("data-theme", 'light')
  }
}
