<?php

declare(strict_types=1);

use Drupal\Core\Form\FormStateInterface;
use Drupal\RecipeKit\Installer\Hooks;
use Drupal\RecipeKit\Installer\Messenger;

/**
 * Implements hook_install_tasks().
 */
function drupal_cms_installer_install_tasks(): array {
  $tasks = Hooks::installTasks();

  if (getenv('IS_DDEV_PROJECT')) {
    Messenger::reject(
      'All necessary changes to %dir and %file have been made, so you should remove write permissions to them now in order to avoid security risks. If you are unsure how to do so, consult the <a href=":handbook_url">online handbook</a>.',
    );
  }
  return $tasks;
}

/**
 * Implements hook_install_tasks_alter().
 */
function drupal_cms_installer_install_tasks_alter(array &$tasks, array $install_state): void {
  Hooks::installTasksAlter($tasks, $install_state);
}

/**
 * Implements hook_form_alter().
 */
function drupal_cms_installer_form_alter(array &$form, FormStateInterface $form_state, string $form_id): void {
  Hooks::formAlter($form, $form_state, $form_id);
}

/**
 * Implements hook_form_alter() for install_configure_form.
 */
function drupal_cms_installer_form_install_configure_form_alter(array &$form): void {
  // We always install Automatic Updates, so we don't need to expose the update
  // notification settings.
  $form['update_notifications']['#access'] = FALSE;
}
