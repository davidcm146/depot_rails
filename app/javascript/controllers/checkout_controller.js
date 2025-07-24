import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkout"
export default class extends Controller {
  static targets = ["button"]
  connect() {
    console.log("Checkout controller connected");
    console.log(this.buttonTarget);
  }

  checkIfOnCheckoutPage(event) {
    if (window.location.pathname.includes("orders/new")) {
      event.preventDefault()
      this.buttonTarget.disabled = true
      this.buttonTarget.classList.add("opacity-50", "cursor-not-allowed")
    }
  }
}
