<script setup lang="ts">
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger
} from '@/components/ui/accordion'

interface FAQProps {
  question: string
  answer: string
  value: string
}

const FAQList: FAQProps[] = [
  {
    question: 'Is the Timer Manager easy to use?',
    answer:
      'Yes, the Timer Manager is designed with a simple and intuitive interface, making it easy for all employees to log their working hours.',
    value: 'item-1'
  },
  {
    question: 'Can I track overtime with this tool?',
    answer:
      'Yes, the Timer Manager allows you to track both regular working hours and overtime, ensuring full transparency in time management.',
    value: 'item-2'
  },
  {
    question: 'Will my personal data be secure?',
    answer:
      'Absolutely. The Timer Manager uses robust security measures to protect your personal data and ensure privacy.',
    value: 'item-3'
  },
  {
    question: 'What should I do if I forget to log my hours?',
    answer:
      'You can easily submit a request to modify or add missed hours through the app, subject to approval by your manager.',
    value: 'item-4'
  },
  {
    question: 'How will this app affect my flexibility at work?',
    answer:
      'The Timer Manager is built to respect your work-life balance, offering flexibility in logging hours while ensuring accuracy in tracking time.',
    value: 'item-5'
  },
  {
    question: 'Can I submit complaints or requests through the app?',
    answer:
      'Yes, you can submit any concerns, claims, or requests directly through the Timer Manager, ensuring your feedback reaches the administration quickly.',
    value: 'item-6'
  }
]
</script>

<template>
  <section id="faq" class="container md:w-[700px] py-24 sm:py-32">
    <div class="text-center mb-8">
      <h2 class="text-lg text-primary text-center mb-2 tracking-wider">FAQS</h2>

      <h2 class="text-3xl md:text-4xl text-center font-bold">Common Questions</h2>
    </div>

    <Accordion type="single" collapsible class="AccordionRoot">
      <AccordionItem v-for="{ question, answer, value } in FAQList" :key="value" :value="value">
        <AccordionTrigger class="text-left"> {{ question }} </AccordionTrigger>

        <AccordionContent>{{ answer }}</AccordionContent>
      </AccordionItem>
    </Accordion>

    <h3 class="font-medium mt-4">
      Still have questions?
      <a href="#" class="text-muted-foreground">
        <a href="#contact" class="underline">Contact us</a>
      </a>
    </h3>
  </section>
</template>
