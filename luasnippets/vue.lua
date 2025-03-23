return {
	s({ trig = 'comp' },
		fmt([[
      <script setup>
        {}
      </script>

      <template>
        <div></div>
      </template>

      <style>

      </style>
    ]], { i(0) })),
	s({ trig = 'comp:ts' },
		fmt([[
      <script setup lang="ts">
        {}
      </script>

      <template>
        <div></div>
      </template>

      <style>

      </style>
    ]], { i(0) })),
}
