import Vue from 'vue/dist/vue.esm';
import { RECIPE_TYPES } from './constant';
import axios from 'axios';
import InfiniteLoading from 'vue-infinite-loading';
Vue.use(InfiniteLoading);
const ujs = require('rails-ujs');

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#cooking',
    data: {
      cooking_records: [],
      main_dish_records: [],
      side_dish_records: [],
      bookmark_records: [],
      soup_records: [],
      records_total_count: 0,
      offset: 0,
      initialized: false,
    },
    created() {
      this.fetchCookingRecords();
      this.fetchBookmarkRecords();
    },
    methods: {
      castRecipeType(type) {
        return RECIPE_TYPES[type];
      },
      fetchCookingRecords() {
        const params = {
          offset: this.offset,
        };
        axios
          .get('/api/internal/fetch_cooking_records', { params })
          .then((response) => {
            this.cooking_records = [
              ...this.cooking_records,
              ...response.data.cooking_records,
            ];
            this.partRecipeType(response.data.cooking_records);
            this.records_total_count = response.data.pagination.total;
            this.offset = this.offset + 6;
            this.initialized = true;
          });
      },
      partRecipeType(records) {
        const mainDish = records.filter(
          (record) => record.recipe_type === 'main_dish'
        );
        const sideDish = records.filter(
          (record) => record.recipe_type === 'side_dish'
        );
        const soup = records.filter((record) => record.recipe_type === 'soup');
        this.main_dish_records = [...this.main_dish_records, ...mainDish];
        this.side_dish_records = [...this.side_dish_records, ...sideDish];
        this.soup_records = [...this.soup_records, ...soup];
      },
      infiniteHandler($state) {
        if (this.cooking_records.length === this.records_total_count) {
          $state.complete();
        } else {
          setTimeout(() => {
            this.fetchCookingRecords();
            $state.loaded();
          }, 1500);
        }
      },
      createBookmark(record, index) {
        const bookmarkParams = {
          image_url: record.image_url,
          comment: record.comment,
          recipe_type: record.recipe_type,
        };
        axios.defaults.headers.common['X-CSRF-Token'] = ujs.csrfToken();
        axios
          .post('/api/internal/bookmarks', { bookmark: bookmarkParams })
          .then((response) => {
            this.bookmark_records = response.data.bookmarks;
            record.bookmark = true;
            // const bookmarkImageUrls = this.bookmark_records.map(
            //   (bookmark) => bookmark.image_url
            // );
            // console.log();
            // this.$set(this.main_dish_records[index], 'bookmark', true);

            // this.main_dish_records.splice(index, 1, { bookmark: true });
            // this.$nextTick(function() {
            //   this.main_dish_records.splice(index, 1, { bookmark: true });
            // });
            // console.log(record);
            // record.bookmark = true;
            // console.log(record);
          });
      },
      fetchBookmarkRecords() {
        axios.get('/api/internal/bookmarks').then((response) => {
          this.bookmark_records = response.data.bookmarks;
        });
      },
    },
  });
});
