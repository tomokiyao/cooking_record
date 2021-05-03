import Vue from 'vue/dist/vue.esm';
import { RECIPE_TYPES } from './constant';
import axios from 'axios';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#cooking',
    data: {
      cooking_records: [],
    },
    created() {
      axios
        .get('/api/internal/fetch_cooking_records')
        .then(
          (response) =>
            (this.cooking_records = [
              ...this.cooking_records,
              ...response.data.cooking_records,
            ])
        );
    },
    methods: {
      castRecipeType(type) {
        return RECIPE_TYPES[type];
      },
    },
  });
});
