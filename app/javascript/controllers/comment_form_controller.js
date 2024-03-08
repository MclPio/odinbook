import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  toggleForm(event) {
    event.preventDefault();
    this.formTarget.classList.toggle("hide")
  }
}
