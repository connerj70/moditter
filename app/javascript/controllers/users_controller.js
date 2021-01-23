import { Controller } from 'stimulus'; 
export default class extends Controller {
  toggleHide(event) {
    event.srcElement.parentElement.childNodes[1].classList.remove("hidden");
  }
}