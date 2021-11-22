<template>
  <div id="nav">
    <a :href="root">Root</a> |
    <a :href="alpha">Alpha</a> |
    <a :href="beta">Beta</a> |
    <router-link :to="{ name: 'Home' }">Home</router-link> |
    <router-link :to="{ name: 'About' }">about?</router-link>
  </div>
</template>

<script>
export default {
  data() {
    return {
      root: process.env.VUE_APP_FE_HOST_ROOT,
      alpha: process.env.VUE_APP_FE_HOST_ALPHA,
      beta: process.env.VUE_APP_FE_HOST_BETA,
    };
  },
}
</script>

<style scoped>

</style>