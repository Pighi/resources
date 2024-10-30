new Vue({
  el: '#app',
  data: {
    searchQuery: '',
    tilesData: [],
    selectedCar: null,
    selectedColor: null,
    selectedMinutes: 15,
    colors: ['white', 'red', 'pink', 'green', 'limegreen', 'orange', 'brown', 'purple', 'grey', 'blue', 'black'],
    isMiddleMouseDown: false,
  },
  mounted() {
    window.addEventListener('message', event => {
      const eventData = event.data;
      switch (eventData.type) {
        case "open":
          this.tilesData = eventData.cars;
          document.getElementById("app").style.display = "block";
          document.body.style.display = "block";
          break;
        case "close":
          this.selectedCar = null;
          this.selectedColor = null;
          this.selectedMinutes = 15;
          document.getElementById("app").style.display = "none";
          document.body.style.display = "none";
          break;
        default:
          break;
      }
    });
    window.addEventListener('keyup', keyData => {
      if (keyData.key == "Escape") {
        this.selectedCar = null;
        this.selectedColor = null;
        this.selectedMinutes = 15;
        document.getElementById("app").style.display = "none";
        document.body.style.display = "none";

        fetch(`https://${GetParentResourceName()}/close`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({}),
        });
      }
    });

    // Add mouse event listeners
    document.body.addEventListener('mousedown', this.handleMouseDown);
    document.body.addEventListener('mouseup', this.handleMouseUp);
    document.body.addEventListener('mousemove', this.handleMouseMove);
  },
  beforeDestroy() {
    // Remove mouse event listeners
    document.body.removeEventListener('mousedown', this.handleMouseDown);
    document.body.removeEventListener('mouseup', this.handleMouseUp);
    document.body.removeEventListener('mousemove', this.handleMouseMove);
  },
  computed: {
    filteredData() {
      return this.tilesData.filter(item => {
        return (
          item.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
          item.model.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
      });
    },
    totalPrice() {
      if (this.selectedCar) {
        return `$${(this.selectedCar.price * (this.selectedMinutes / 60)).toFixed(3)}`;
      } else {
        return '';
      }
    },
  },
  methods: {
    searchCars() {
      const searchInput = this.$refs.searchInput;
      if (searchInput) {
        this.searchQuery = searchInput.value.trim();
      }
    },
    parkedOut(car) {
      this.selectedCar = car;
      console.log(`Parked Out: "${car.name}" - Price: "${car.price}"`);
      fetch(`https://${GetParentResourceName()}/selectCar`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({ car }),
      });
    },
    payWithCard() {
      if (this.selectedCar) {
        console.log(`Payed with Card: "${this.selectedCar.price}" - Color: "${this.selectedColor}" - Minutes: "${this.selectedMinutes}"`);
        fetch(`https://${GetParentResourceName()}/pay`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({ color: this.selectedColor, minutes: this.selectedMinutes, car: this.selectedCar, type: "card" }),
        });
      }
    },
    payWithCash() {
      if (this.selectedCar) {
        console.log(`Payed with Cash: "${this.selectedCar.price}" - Color: "${this.selectedColor}" - Minutes: "${this.selectedMinutes}"`);
        fetch(`https://${GetParentResourceName()}/pay`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({ color: this.selectedColor, minutes: this.selectedMinutes, car: this.selectedCar, type: "cash" }),
        });
      }
    },
    selectColor(color) {
      this.selectedColor = color;
      console.log(`Selected Color: "${color}"`);
      fetch(`https://${GetParentResourceName()}/selectColor`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({ color }),
      });
    },
    changeMinutes(delta) {
      this.selectedMinutes += delta;
      if (this.selectedMinutes < 15) {
        this.selectedMinutes = 15;
      }
      console.log(`Selected Minutes: "${this.selectedMinutes}"`);
    },
    // New methods for mouse events
    handleMouseDown(event) {
      if (event.button === 0) {
        this.isMiddleMouseDown = true;
      }
    },
    handleMouseUp(event) {
      if (event.button === 0) {
        this.isMiddleMouseDown = false;
      }
    },
    handleMouseMove(event) {
      if (this.isMiddleMouseDown) {
        const deltaX = event.movementX;
        this.postMouseDataToLua(deltaX);
      }
    },
    postMouseDataToLua(deltaX) {
      fetch(`https://${GetParentResourceName()}/mouseData`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({ deltaX }),
      });
    },
  },
});
